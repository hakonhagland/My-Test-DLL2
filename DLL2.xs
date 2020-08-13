#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <gsl/gsl_errno.h>

MODULE = My::Test::DLL2  PACKAGE = My::Test::DLL2
PROTOTYPES: DISABLE

void
error_edom(msg)
    const char *msg

  CODE:
    gsl_error(msg, __FILE__, __LINE__, GSL_EDOM);


SV *
set_error_handler_off()
  CODE:
     gsl_error_handler_t *old_handler = gsl_set_error_handler_off();
     RETVAL = newSVuv(PTR2IV(old_handler));

  OUTPUT:
     RETVAL
