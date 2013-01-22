#ifndef PERL_CONVERSION_FUNCTIONS_H_
#define PERL_CONVERSION_FUNCTIONS_H_

/* WARNING!
 * This code is autogenerated. Have a look at author_tools/regen.pl and
 * its friend author_tools/struct_to_hash.pl!
 */

#include <EXTERN.h>
#include <perl.h>

#include <ap.h>
#include <interpolation.h>

/* used by the real_1d_array typemap, but also usable separately */
AV *
real_1d_array_to_av(pTHX_ const alglib::real_1d_array &x)
{
  const unsigned int len = x.length();
  AV *av = newAV();
  unsigned int i;
  av_extend(av, len-1);
  for (i = 0; i < len; ++i)
    av_store(av, i, newSVnv(x[i]));
  return av;
}

/* used by the integer_1d_array typemap, but also usable separately */
AV *
integer_1d_array_to_av(pTHX_ const alglib::integer_1d_array &x)
{
  const unsigned int len = x.length();
  AV *av = newAV();
  unsigned int i;
  av_extend(av, len-1);
  for (i = 0; i < len; ++i)
    av_store(av, i, newSViv(x[i]));
  return av;
}


/* used by integration.h to return an arrayref of a status int
 * followed by two real_1d_array's */
SV *
integration_return_status_ary_ary(pTHX_ IV info,
                                  const alglib::real_1d_array &x,
                                  const alglib::real_1d_array &w,
                                  alglib::real_1d_array *opt = NULL)
{
  AV *av = newAV();
  SV *retval = newRV_noinc((SV *)av);
  av_extend(av, opt == NULL ? 2 : 3);
  av_store(av, 0, newSViv(info));
  av_store(av, 1, newRV_noinc((SV *) real_1d_array_to_av(aTHX_ x)));
  av_store(av, 2, newRV_noinc((SV *) real_1d_array_to_av(aTHX_ w)));
  if (opt != NULL)
    av_store(av, 3, newRV_noinc((SV *) real_1d_array_to_av(aTHX_ *opt)));
  return retval;
}

/* turns polynomialfitreport into a hashref for output */
SV *
polynomialfitreport_to_hvref(pTHX_ const alglib::polynomialfitreport &rep)
{
  HV* hv = newHV();
  SV *rv = newRV_noinc((SV*)hv);
  hv_stores(hv, "taskrcond", newSVnv(rep.taskrcond));
  hv_stores(hv, "rmserror", newSVnv(rep.rmserror));
  hv_stores(hv, "avgerror", newSVnv(rep.avgerror));
  hv_stores(hv, "avgrelerror", newSVnv(rep.avgrelerror));
  hv_stores(hv, "maxerror", newSVnv(rep.maxerror));
  return rv;
}

/* Given an arbitrary ptr and a class name, returns a blessed scalar,
 * traditional XS style... */
SV *
ptr_to_perl_obj(pTHX_ void *ptr, const char *CLASS)
{
  SV *obj;
  obj = newSV(0);
  sv_setref_pv(obj, CLASS, ptr);
  return obj;
}


using namespace alglib; /* FIXME hack */


#endif
