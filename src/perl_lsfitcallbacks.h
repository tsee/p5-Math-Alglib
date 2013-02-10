#ifndef PERL_LSFITCALLBACKS_H_
#define PERL_LSFITCALLBACKS_H_ 
#include <interpolation.h>
using namespace alglib;

class xs_lsfit_cb_state {
public:
  xs_lsfit_cb_state(pTHX_ SV *obj)
  {
#ifdef PERL_IMPLICIT_CONTEXT
    this->perl_thread_context = aTHX;
#endif

    /* no refcnt needed for lsfit_object slot since the AV below holds one */
    this->lsfit_object = obj;
    this->cb_rvs = newAV();
    this->cb_args = newAV();
    SvREFCNT_inc(obj);
    av_push(this->cb_args, obj);
  }

  ~xs_lsfit_cb_state()
  {
#ifdef PERL_IMPLICIT_CONTEXT
    tTHX my_perl = this->perl_thread_context;
#endif
    SvREFCNT_dec(this->cb_args);
    SvREFCNT_dec(this->cb_rvs);
  }


#ifdef PERL_IMPLICIT_CONTEXT
  tTHX perl_thread_context;
#endif
  CV *func_callback;
  CV *grad_callback;

  SV *lsfit_object;
  AV *cb_args;
  AV *cb_rvs;
};

void
perl_function_call(pTHX_ CV *fun, int flags, AV *args, AV *rvs, int nretvals)
{
  dSP;
  ENTER;
  SAVETMPS;

  PUSHMARK(SP);

  SV **elem;
  unsigned int n = av_len(args)+1;
  unsigned int i;
  EXTEND(SP, n);
  for (i = 0; i < n; ++i) {
    elem = av_fetch(args, i, 0);
    if (!elem)
      PUSHs(&PL_sv_undef);
    else
      PUSHs(*elem);
  }

  PUTBACK;

  int count = call_sv((SV *)fun, flags);
  
  SPAGAIN;

  if (count != nretvals)
    croak("Need %i return values from callback, got %i", nretvals, count);

  av_extend(rvs, nretvals-1);
  for (i = 0; i < nretvals; ++i) {
    SV *rv = POPs;
    SvREFCNT_inc(rv);
    av_store(rvs, i, rv);
  }

  PUTBACK;
  FREETMPS;
  LEAVE;
}

/* C callback for "func" to execute perl callback to fill "double func" */
void
lsfit_callback_func(const real_1d_array &c, const real_1d_array &x, double &func, void *ptr)
{
  xs_lsfit_cb_state *state = (xs_lsfit_cb_state *)ptr;
  /* get perl context without dTHX */
#ifdef PERL_IMPLICIT_CONTEXT
  tTHX my_perl = state->perl_thread_context;
#endif

  if (state->func_callback == NULL)
    croak("Panic: Missing func callback!");

  SV *csv = newRV_noinc((SV *)real_1d_array_to_av(aTHX_ c));
  SV *xsv = newRV_noinc((SV *)real_1d_array_to_av(aTHX_ x));
  av_extend(state->cb_args, 2); /* obj already in 0 */
  av_store(state->cb_args, 1, csv);
  av_store(state->cb_args, 2, xsv);

  perl_function_call(aTHX_ state->func_callback, G_SCALAR, state->cb_args, state->cb_rvs, 1);

  func = SvNV(*av_fetch(state->cb_rvs, 0, 0));

  av_clear(state->cb_rvs);
}

/* C callback for "grad" to execute perl callback to fill "double func" and "real_1d_array grad" */
void
lsfit_callback_grad(const real_1d_array &c, const real_1d_array &x, double &func, real_1d_array &grad, void *ptr)
{
  xs_lsfit_cb_state *state = (xs_lsfit_cb_state *)ptr;
  /* get perl context without dTHX */
#ifdef PERL_IMPLICIT_CONTEXT
  tTHX my_perl = state->perl_thread_context;
#endif

  if (state->grad_callback == NULL)
    croak("Panic: Missing grad callback!");

  SV *csv = sv_2mortal(newRV_noinc((SV *)real_1d_array_to_av(aTHX_ c)));
  SV *xsv = sv_2mortal(newRV_noinc((SV *)real_1d_array_to_av(aTHX_ x)));
  av_extend(state->cb_args, 2); /* obj already in 0 */
  av_store(state->cb_args, 1, csv);
  av_store(state->cb_args, 2, xsv);

  perl_function_call(aTHX_ state->grad_callback, G_ARRAY, state->cb_args, state->cb_rvs, 2);

  func = SvNV(*av_fetch(state->cb_rvs, 0, 0));
  
  SV *ret_av = *av_fetch(state->cb_rvs, 1, 0);
  SvGETMAGIC(ret_av);
  if (!SvROK(ret_av) || SvTYPE(ret_av) != SVt_PVAV)
    croak("Expect array ref as second return value");
  av_to_real_1d_array(aTHX_ (AV *)SvRV(ret_av), grad);

  av_clear(state->cb_rvs);
}

#endif
