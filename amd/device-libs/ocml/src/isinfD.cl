
#include "mathD.h"

CONSTATTR INLINEATTR int
MATH_MANGLE(isinf)(double x)
{
    return BUILTIN_CLASS_F64(x, CLASS_PINF|CLASS_NINF);
}

