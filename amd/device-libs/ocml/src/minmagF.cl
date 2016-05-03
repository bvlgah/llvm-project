
#include "mathF.h"

CONSTATTR INLINEATTR float
MATH_MANGLE(minmag)(float x, float y)
{
#if 0
    int ix = as_int(x);
    int iy = as_int(y);
    int ax = ix & 0x7fffffff;
    int ay = iy & 0x7fffffff;
    return as_float((-(ax < ay) & ix) |
	            (-(ay < ax) & iy) |
		    (-(ax == ay) & (ix | iy)));
#else
    x = BUILTIN_CANONICALIZE_F32(x);
    y = BUILTIN_CANONICALIZE_F32(y);
    float ret = BUILTIN_MIN_F32(x, y);
    float ax = BUILTIN_ABS_F32(x);
    float ay = BUILTIN_ABS_F32(y);
    ret = ax < ay ? x : ret;
    ret = ay < ax ? y : ret;
    return ret;
#endif
}

