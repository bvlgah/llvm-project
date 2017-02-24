/*===--------------------------------------------------------------------------
 *                   ROCm Device Libraries
 *
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE.TXT for details.
 *===------------------------------------------------------------------------*/

#include "oclc.h"

static __constant uint SI_samplers[] = {
    0x1000b1b6, 0x00fff000, 0x00000000, 0x00000000, // 0x10
    0x100031b6, 0x00fff000, 0x00000000, 0x00000000, // 0x11
    0x1000b092, 0x00fff000, 0x00000000, 0x00000000, // 0x12
    0x10003092, 0x00fff000, 0x00000000, 0x00000000, // 0x13
    0x1000b1b6, 0x00fff000, 0x00000000, 0x00000000, // 0x14
    0x100031b6, 0x00fff000, 0x00000000, 0x00000000, // 0x15
    0x1000b000, 0x00fff000, 0x00000000, 0x00000000, // 0x16
    0x10003000, 0x00fff000, 0x00000000, 0x00000000, // 0x17
    0x1000b049, 0x00fff000, 0x00000000, 0x00000000, // 0x18
    0x10003049, 0x00fff000, 0x00000000, 0x00000000, // 0x19
    0x00000000, 0x00000000, 0x00000000, 0x00000000, // 0x1a
    0x00000000, 0x00000000, 0x00000000, 0x00000000, // 0x1b
    0x00000000, 0x00000000, 0x00000000, 0x00000000, // 0x1c
    0x00000000, 0x00000000, 0x00000000, 0x00000000, // 0x1d
    0x00000000, 0x00000000, 0x00000000, 0x00000000, // 0x1e
    0x00000000, 0x00000000, 0x00000000, 0x00000000, // 0x1f
    0x1000b1b6, 0x00fff000, 0x00500000, 0x00000000, // 0x20
    0x100031b6, 0x00fff000, 0x00500000, 0x00000000, // 0x21
    0x1000b092, 0x00fff000, 0x00500000, 0x00000000, // 0x22
    0x10003092, 0x00fff000, 0x00500000, 0x00000000, // 0x23
    0x1000b1b6, 0x00fff000, 0x00500000, 0x00000000, // 0x24
    0x100031b6, 0x00fff000, 0x00500000, 0x00000000, // 0x25
    0x1000b000, 0x00fff000, 0x00500000, 0x00000000, // 0x26
    0x10003000, 0x00fff000, 0x00500000, 0x00000000, // 0x27
    0x1000b049, 0x00fff000, 0x00500000, 0x00000000, // 0x28
    0x10003049, 0x00fff000, 0x00500000, 0x00000000, // 0x29
};

static __constant uint GFX9_samplers[] = {
    0x1000b1b6, 0x00fff000, 0x80000000, 0x00000000, // 0x10
    0x100031b6, 0x00fff000, 0x80000000, 0x00000000, // 0x11
    0x1000b092, 0x00fff000, 0x80000000, 0x00000000, // 0x12
    0x10003092, 0x00fff000, 0x80000000, 0x00000000, // 0x13
    0x1000b1b6, 0x00fff000, 0x80000000, 0x00000000, // 0x14
    0x100031b6, 0x00fff000, 0x80000000, 0x00000000, // 0x15
    0x1000b000, 0x00fff000, 0x80000000, 0x00000000, // 0x16
    0x10003000, 0x00fff000, 0x80000000, 0x00000000, // 0x17
    0x1000b049, 0x00fff000, 0x80000000, 0x00000000, // 0x18
    0x10003049, 0x00fff000, 0x80000000, 0x00000000, // 0x19
    0x00000000, 0x00000000, 0x00000000, 0x00000000, // 0x1a
    0x00000000, 0x00000000, 0x00000000, 0x00000000, // 0x1b
    0x00000000, 0x00000000, 0x00000000, 0x00000000, // 0x1c
    0x00000000, 0x00000000, 0x00000000, 0x00000000, // 0x1d
    0x00000000, 0x00000000, 0x00000000, 0x00000000, // 0x1e
    0x00000000, 0x00000000, 0x00000000, 0x00000000, // 0x1f
    0x1000b1b6, 0x00fff000, 0x80500000, 0x00000000, // 0x20
    0x100031b6, 0x00fff000, 0x80500000, 0x00000000, // 0x21
    0x1000b092, 0x00fff000, 0x80500000, 0x00000000, // 0x22
    0x10003092, 0x00fff000, 0x80500000, 0x00000000, // 0x23
    0x1000b1b6, 0x00fff000, 0x80500000, 0x00000000, // 0x24
    0x100031b6, 0x00fff000, 0x80500000, 0x00000000, // 0x25
    0x1000b000, 0x00fff000, 0x80500000, 0x00000000, // 0x26
    0x10003000, 0x00fff000, 0x80500000, 0x00000000, // 0x27
    0x1000b049, 0x00fff000, 0x80500000, 0x00000000, // 0x28
    0x10003049, 0x00fff000, 0x80500000, 0x00000000, // 0x29
};

typedef struct { int x, y, z, w; } __sampler_t;

__attribute__((always_inline, const)) __constant __sampler_t *
__translate_sampler_initializer(int i)
{
    if (__oclc_ISA_version() < 900) {
        return (__constant __sampler_t *)&SI_samplers[(i - 16) << 2];
    } else {
        return (__constant __sampler_t *)&GFX9_samplers[(i - 16) << 2];
    }
}

