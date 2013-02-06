#ifndef MYINIT_H_
#define MYINIT_H_
#include <perl_conversion_functions.h>
using namespace alglib;

#define NEW_MORTAL_AV() ((AV *)sv_2mortal((SV *)newAV()))

#endif
