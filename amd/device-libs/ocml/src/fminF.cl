
#include "mathF.h"

CONSTATTR INLINEATTR float
MATH_MANGLE(fmin)(float x, float y)
{
    float ret;

    if (AMD_OPT() & DAZ_OPT() & !FINITE_ONLY_OPT()) {
        // XXX revisit this later
        ret = BUILTIN_CMIN_F32(BUILTIN_CANONICALIZE_F32(x), BUILTIN_CANONICALIZE_F32(y));
    } else {
        if (FINITE_ONLY_OPT()) {
            ret = BUILTIN_MIN_F32(x, y);
        } else {
            ret = BUILTIN_MIN_F32(BUILTIN_CANONICALIZE_F32(x), BUILTIN_CANONICALIZE_F32(y));
        }
    }

    return ret;
}

