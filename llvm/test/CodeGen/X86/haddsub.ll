; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+sse3 | FileCheck %s --check-prefix=SSE3
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+avx | FileCheck %s --check-prefix=AVX

define <2 x double> @haddpd1(<2 x double> %x, <2 x double> %y) {
; SSE3-LABEL: haddpd1:
; SSE3:       # BB#0:
; SSE3-NEXT:    haddpd %xmm1, %xmm0
; SSE3-NEXT:    retq
;
; AVX-LABEL: haddpd1:
; AVX:       # BB#0:
; AVX-NEXT:    vhaddpd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a = shufflevector <2 x double> %x, <2 x double> %y, <2 x i32> <i32 0, i32 2>
  %b = shufflevector <2 x double> %x, <2 x double> %y, <2 x i32> <i32 1, i32 3>
  %r = fadd <2 x double> %a, %b
  ret <2 x double> %r
}

define <2 x double> @haddpd2(<2 x double> %x, <2 x double> %y) {
; SSE3-LABEL: haddpd2:
; SSE3:       # BB#0:
; SSE3-NEXT:    haddpd %xmm1, %xmm0
; SSE3-NEXT:    retq
;
; AVX-LABEL: haddpd2:
; AVX:       # BB#0:
; AVX-NEXT:    vhaddpd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a = shufflevector <2 x double> %x, <2 x double> %y, <2 x i32> <i32 1, i32 2>
  %b = shufflevector <2 x double> %y, <2 x double> %x, <2 x i32> <i32 2, i32 1>
  %r = fadd <2 x double> %a, %b
  ret <2 x double> %r
}

define <2 x double> @haddpd3(<2 x double> %x) {
; SSE3-LABEL: haddpd3:
; SSE3:       # BB#0:
; SSE3-NEXT:    haddpd %xmm0, %xmm0
; SSE3-NEXT:    retq
;
; AVX-LABEL: haddpd3:
; AVX:       # BB#0:
; AVX-NEXT:    vhaddpd %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a = shufflevector <2 x double> %x, <2 x double> undef, <2 x i32> <i32 0, i32 undef>
  %b = shufflevector <2 x double> %x, <2 x double> undef, <2 x i32> <i32 1, i32 undef>
  %r = fadd <2 x double> %a, %b
  ret <2 x double> %r
}

define <4 x float> @haddps1(<4 x float> %x, <4 x float> %y) {
; SSE3-LABEL: haddps1:
; SSE3:       # BB#0:
; SSE3-NEXT:    haddps %xmm1, %xmm0
; SSE3-NEXT:    retq
;
; AVX-LABEL: haddps1:
; AVX:       # BB#0:
; AVX-NEXT:    vhaddps %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a = shufflevector <4 x float> %x, <4 x float> %y, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  %b = shufflevector <4 x float> %x, <4 x float> %y, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
  %r = fadd <4 x float> %a, %b
  ret <4 x float> %r
}

define <4 x float> @haddps2(<4 x float> %x, <4 x float> %y) {
; SSE3-LABEL: haddps2:
; SSE3:       # BB#0:
; SSE3-NEXT:    haddps %xmm1, %xmm0
; SSE3-NEXT:    retq
;
; AVX-LABEL: haddps2:
; AVX:       # BB#0:
; AVX-NEXT:    vhaddps %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a = shufflevector <4 x float> %x, <4 x float> %y, <4 x i32> <i32 1, i32 2, i32 5, i32 6>
  %b = shufflevector <4 x float> %y, <4 x float> %x, <4 x i32> <i32 4, i32 7, i32 0, i32 3>
  %r = fadd <4 x float> %a, %b
  ret <4 x float> %r
}

define <4 x float> @haddps3(<4 x float> %x) {
; SSE3-LABEL: haddps3:
; SSE3:       # BB#0:
; SSE3-NEXT:    haddps %xmm0, %xmm0
; SSE3-NEXT:    retq
;
; AVX-LABEL: haddps3:
; AVX:       # BB#0:
; AVX-NEXT:    vhaddps %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a = shufflevector <4 x float> %x, <4 x float> undef, <4 x i32> <i32 undef, i32 2, i32 4, i32 6>
  %b = shufflevector <4 x float> %x, <4 x float> undef, <4 x i32> <i32 undef, i32 3, i32 5, i32 7>
  %r = fadd <4 x float> %a, %b
  ret <4 x float> %r
}

define <4 x float> @haddps4(<4 x float> %x) {
; SSE3-LABEL: haddps4:
; SSE3:       # BB#0:
; SSE3-NEXT:    haddps %xmm0, %xmm0
; SSE3-NEXT:    retq
;
; AVX-LABEL: haddps4:
; AVX:       # BB#0:
; AVX-NEXT:    vhaddps %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a = shufflevector <4 x float> %x, <4 x float> undef, <4 x i32> <i32 0, i32 2, i32 undef, i32 undef>
  %b = shufflevector <4 x float> %x, <4 x float> undef, <4 x i32> <i32 1, i32 3, i32 undef, i32 undef>
  %r = fadd <4 x float> %a, %b
  ret <4 x float> %r
}

define <4 x float> @haddps5(<4 x float> %x) {
; SSE3-LABEL: haddps5:
; SSE3:       # BB#0:
; SSE3-NEXT:    haddps %xmm0, %xmm0
; SSE3-NEXT:    retq
;
; AVX-LABEL: haddps5:
; AVX:       # BB#0:
; AVX-NEXT:    vhaddps %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a = shufflevector <4 x float> %x, <4 x float> undef, <4 x i32> <i32 0, i32 3, i32 undef, i32 undef>
  %b = shufflevector <4 x float> %x, <4 x float> undef, <4 x i32> <i32 1, i32 2, i32 undef, i32 undef>
  %r = fadd <4 x float> %a, %b
  ret <4 x float> %r
}

define <4 x float> @haddps6(<4 x float> %x) {
; SSE3-LABEL: haddps6:
; SSE3:       # BB#0:
; SSE3-NEXT:    haddps %xmm0, %xmm0
; SSE3-NEXT:    retq
;
; AVX-LABEL: haddps6:
; AVX:       # BB#0:
; AVX-NEXT:    vhaddps %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a = shufflevector <4 x float> %x, <4 x float> undef, <4 x i32> <i32 0, i32 undef, i32 undef, i32 undef>
  %b = shufflevector <4 x float> %x, <4 x float> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %r = fadd <4 x float> %a, %b
  ret <4 x float> %r
}

define <4 x float> @haddps7(<4 x float> %x) {
; SSE3-LABEL: haddps7:
; SSE3:       # BB#0:
; SSE3-NEXT:    haddps %xmm0, %xmm0
; SSE3-NEXT:    retq
;
; AVX-LABEL: haddps7:
; AVX:       # BB#0:
; AVX-NEXT:    vhaddps %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a = shufflevector <4 x float> %x, <4 x float> undef, <4 x i32> <i32 undef, i32 3, i32 undef, i32 undef>
  %b = shufflevector <4 x float> %x, <4 x float> undef, <4 x i32> <i32 undef, i32 2, i32 undef, i32 undef>
  %r = fadd <4 x float> %a, %b
  ret <4 x float> %r
}

define <2 x double> @hsubpd1(<2 x double> %x, <2 x double> %y) {
; SSE3-LABEL: hsubpd1:
; SSE3:       # BB#0:
; SSE3-NEXT:    hsubpd %xmm1, %xmm0
; SSE3-NEXT:    retq
;
; AVX-LABEL: hsubpd1:
; AVX:       # BB#0:
; AVX-NEXT:    vhsubpd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a = shufflevector <2 x double> %x, <2 x double> %y, <2 x i32> <i32 0, i32 2>
  %b = shufflevector <2 x double> %x, <2 x double> %y, <2 x i32> <i32 1, i32 3>
  %r = fsub <2 x double> %a, %b
  ret <2 x double> %r
}

define <2 x double> @hsubpd2(<2 x double> %x) {
; SSE3-LABEL: hsubpd2:
; SSE3:       # BB#0:
; SSE3-NEXT:    hsubpd %xmm0, %xmm0
; SSE3-NEXT:    retq
;
; AVX-LABEL: hsubpd2:
; AVX:       # BB#0:
; AVX-NEXT:    vhsubpd %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a = shufflevector <2 x double> %x, <2 x double> undef, <2 x i32> <i32 0, i32 undef>
  %b = shufflevector <2 x double> %x, <2 x double> undef, <2 x i32> <i32 1, i32 undef>
  %r = fsub <2 x double> %a, %b
  ret <2 x double> %r
}

define <4 x float> @hsubps1(<4 x float> %x, <4 x float> %y) {
; SSE3-LABEL: hsubps1:
; SSE3:       # BB#0:
; SSE3-NEXT:    hsubps %xmm1, %xmm0
; SSE3-NEXT:    retq
;
; AVX-LABEL: hsubps1:
; AVX:       # BB#0:
; AVX-NEXT:    vhsubps %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a = shufflevector <4 x float> %x, <4 x float> %y, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  %b = shufflevector <4 x float> %x, <4 x float> %y, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
  %r = fsub <4 x float> %a, %b
  ret <4 x float> %r
}

define <4 x float> @hsubps2(<4 x float> %x) {
; SSE3-LABEL: hsubps2:
; SSE3:       # BB#0:
; SSE3-NEXT:    hsubps %xmm0, %xmm0
; SSE3-NEXT:    retq
;
; AVX-LABEL: hsubps2:
; AVX:       # BB#0:
; AVX-NEXT:    vhsubps %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a = shufflevector <4 x float> %x, <4 x float> undef, <4 x i32> <i32 undef, i32 2, i32 4, i32 6>
  %b = shufflevector <4 x float> %x, <4 x float> undef, <4 x i32> <i32 undef, i32 3, i32 5, i32 7>
  %r = fsub <4 x float> %a, %b
  ret <4 x float> %r
}

define <4 x float> @hsubps3(<4 x float> %x) {
; SSE3-LABEL: hsubps3:
; SSE3:       # BB#0:
; SSE3-NEXT:    hsubps %xmm0, %xmm0
; SSE3-NEXT:    retq
;
; AVX-LABEL: hsubps3:
; AVX:       # BB#0:
; AVX-NEXT:    vhsubps %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a = shufflevector <4 x float> %x, <4 x float> undef, <4 x i32> <i32 0, i32 2, i32 undef, i32 undef>
  %b = shufflevector <4 x float> %x, <4 x float> undef, <4 x i32> <i32 1, i32 3, i32 undef, i32 undef>
  %r = fsub <4 x float> %a, %b
  ret <4 x float> %r
}

define <4 x float> @hsubps4(<4 x float> %x) {
; SSE3-LABEL: hsubps4:
; SSE3:       # BB#0:
; SSE3-NEXT:    hsubps %xmm0, %xmm0
; SSE3-NEXT:    retq
;
; AVX-LABEL: hsubps4:
; AVX:       # BB#0:
; AVX-NEXT:    vhsubps %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
  %a = shufflevector <4 x float> %x, <4 x float> undef, <4 x i32> <i32 0, i32 undef, i32 undef, i32 undef>
  %b = shufflevector <4 x float> %x, <4 x float> undef, <4 x i32> <i32 1, i32 undef, i32 undef, i32 undef>
  %r = fsub <4 x float> %a, %b
  ret <4 x float> %r
}

define <8 x float> @vhaddps1(<8 x float> %x, <8 x float> %y) {
; SSE3-LABEL: vhaddps1:
; SSE3:       # BB#0:
; SSE3-NEXT:    haddps %xmm2, %xmm0
; SSE3-NEXT:    haddps %xmm3, %xmm1
; SSE3-NEXT:    retq
;
; AVX-LABEL: vhaddps1:
; AVX:       # BB#0:
; AVX-NEXT:    vhaddps %ymm1, %ymm0, %ymm0
; AVX-NEXT:    retq
  %a = shufflevector <8 x float> %x, <8 x float> %y, <8 x i32> <i32 0, i32 2, i32 8, i32 10, i32 4, i32 6, i32 12, i32 14>
  %b = shufflevector <8 x float> %x, <8 x float> %y, <8 x i32> <i32 1, i32 3, i32 9, i32 11, i32 5, i32 7, i32 13, i32 15>
  %r = fadd <8 x float> %a, %b
  ret <8 x float> %r
}

define <8 x float> @vhaddps2(<8 x float> %x, <8 x float> %y) {
; SSE3-LABEL: vhaddps2:
; SSE3:       # BB#0:
; SSE3-NEXT:    haddps %xmm2, %xmm0
; SSE3-NEXT:    haddps %xmm3, %xmm1
; SSE3-NEXT:    retq
;
; AVX-LABEL: vhaddps2:
; AVX:       # BB#0:
; AVX-NEXT:    vhaddps %ymm1, %ymm0, %ymm0
; AVX-NEXT:    retq
  %a = shufflevector <8 x float> %x, <8 x float> %y, <8 x i32> <i32 1, i32 2, i32 9, i32 10, i32 5, i32 6, i32 13, i32 14>
  %b = shufflevector <8 x float> %y, <8 x float> %x, <8 x i32> <i32 8, i32 11, i32 0, i32 3, i32 12, i32 15, i32 4, i32 7>
  %r = fadd <8 x float> %a, %b
  ret <8 x float> %r
}

define <8 x float> @vhaddps3(<8 x float> %x) {
; SSE3-LABEL: vhaddps3:
; SSE3:       # BB#0:
; SSE3-NEXT:    haddps %xmm0, %xmm0
; SSE3-NEXT:    haddps %xmm1, %xmm1
; SSE3-NEXT:    retq
;
; AVX-LABEL: vhaddps3:
; AVX:       # BB#0:
; AVX-NEXT:    vhaddps %ymm0, %ymm0, %ymm0
; AVX-NEXT:    retq
  %a = shufflevector <8 x float> %x, <8 x float> undef, <8 x i32> <i32 undef, i32 2, i32 8, i32 10, i32 4, i32 6, i32 undef, i32 14>
  %b = shufflevector <8 x float> %x, <8 x float> undef, <8 x i32> <i32 1, i32 3, i32 9, i32 undef, i32 5, i32 7, i32 13, i32 15>
  %r = fadd <8 x float> %a, %b
  ret <8 x float> %r
}

define <8 x float> @vhsubps1(<8 x float> %x, <8 x float> %y) {
; SSE3-LABEL: vhsubps1:
; SSE3:       # BB#0:
; SSE3-NEXT:    hsubps %xmm2, %xmm0
; SSE3-NEXT:    hsubps %xmm3, %xmm1
; SSE3-NEXT:    retq
;
; AVX-LABEL: vhsubps1:
; AVX:       # BB#0:
; AVX-NEXT:    vhsubps %ymm1, %ymm0, %ymm0
; AVX-NEXT:    retq
  %a = shufflevector <8 x float> %x, <8 x float> %y, <8 x i32> <i32 0, i32 2, i32 8, i32 10, i32 4, i32 6, i32 12, i32 14>
  %b = shufflevector <8 x float> %x, <8 x float> %y, <8 x i32> <i32 1, i32 3, i32 9, i32 11, i32 5, i32 7, i32 13, i32 15>
  %r = fsub <8 x float> %a, %b
  ret <8 x float> %r
}

define <8 x float> @vhsubps3(<8 x float> %x) {
; SSE3-LABEL: vhsubps3:
; SSE3:       # BB#0:
; SSE3-NEXT:    hsubps %xmm0, %xmm0
; SSE3-NEXT:    hsubps %xmm1, %xmm1
; SSE3-NEXT:    retq
;
; AVX-LABEL: vhsubps3:
; AVX:       # BB#0:
; AVX-NEXT:    vhsubps %ymm0, %ymm0, %ymm0
; AVX-NEXT:    retq
  %a = shufflevector <8 x float> %x, <8 x float> undef, <8 x i32> <i32 undef, i32 2, i32 8, i32 10, i32 4, i32 6, i32 undef, i32 14>
  %b = shufflevector <8 x float> %x, <8 x float> undef, <8 x i32> <i32 1, i32 3, i32 9, i32 undef, i32 5, i32 7, i32 13, i32 15>
  %r = fsub <8 x float> %a, %b
  ret <8 x float> %r
}

define <4 x double> @vhaddpd1(<4 x double> %x, <4 x double> %y) {
; SSE3-LABEL: vhaddpd1:
; SSE3:       # BB#0:
; SSE3-NEXT:    haddpd %xmm2, %xmm0
; SSE3-NEXT:    haddpd %xmm3, %xmm1
; SSE3-NEXT:    retq
;
; AVX-LABEL: vhaddpd1:
; AVX:       # BB#0:
; AVX-NEXT:    vhaddpd %ymm1, %ymm0, %ymm0
; AVX-NEXT:    retq
  %a = shufflevector <4 x double> %x, <4 x double> %y, <4 x i32> <i32 0, i32 4, i32 2, i32 6>
  %b = shufflevector <4 x double> %x, <4 x double> %y, <4 x i32> <i32 1, i32 5, i32 3, i32 7>
  %r = fadd <4 x double> %a, %b
  ret <4 x double> %r
}

define <4 x double> @vhsubpd1(<4 x double> %x, <4 x double> %y) {
; SSE3-LABEL: vhsubpd1:
; SSE3:       # BB#0:
; SSE3-NEXT:    hsubpd %xmm2, %xmm0
; SSE3-NEXT:    hsubpd %xmm3, %xmm1
; SSE3-NEXT:    retq
;
; AVX-LABEL: vhsubpd1:
; AVX:       # BB#0:
; AVX-NEXT:    vhsubpd %ymm1, %ymm0, %ymm0
; AVX-NEXT:    retq
  %a = shufflevector <4 x double> %x, <4 x double> %y, <4 x i32> <i32 0, i32 4, i32 2, i32 6>
  %b = shufflevector <4 x double> %x, <4 x double> %y, <4 x i32> <i32 1, i32 5, i32 3, i32 7>
  %r = fsub <4 x double> %a, %b
  ret <4 x double> %r
}

define <2 x float> @haddps_v2f32(<4 x float> %v0) {
; SSE3-LABEL: haddps_v2f32:
; SSE3:       # BB#0:
; SSE3-NEXT:    haddps %xmm0, %xmm0
; SSE3-NEXT:    retq
;
; AVX-LABEL: haddps_v2f32:
; AVX:       # BB#0:
; AVX-NEXT:    vhaddps %xmm0, %xmm0, %xmm0
; AVX-NEXT:    retq
  %v0.0 = extractelement <4 x float> %v0, i32 0
  %v0.1 = extractelement <4 x float> %v0, i32 1
  %v0.2 = extractelement <4 x float> %v0, i32 2
  %v0.3 = extractelement <4 x float> %v0, i32 3
  %op0 = fadd float %v0.0, %v0.1
  %op1 = fadd float %v0.2, %v0.3
  %res0 = insertelement <2 x float> undef, float %op0, i32 0
  %res1 = insertelement <2 x float> %res0, float %op1, i32 1
  ret <2 x float> %res1
}

define <4 x float> @PR34111(<4 x float> %a) {
; SSE3-LABEL: PR34111:
; SSE3:       # BB#0:
; SSE3-NEXT:    haddps %xmm0, %xmm0
; SSE3-NEXT:    movddup {{.*#+}} xmm0 = xmm0[0,0]
; SSE3-NEXT:    retq
;
; AVX-LABEL: PR34111:
; AVX:       # BB#0:
; AVX-NEXT:    vhaddps %xmm0, %xmm0, %xmm0
; AVX-NEXT:    vmovddup {{.*#+}} xmm0 = xmm0[0,0]
; AVX-NEXT:    retq
  %a02 = shufflevector <4 x float> %a, <4 x float> undef, <2 x i32> <i32 0, i32 2>
  %a13 = shufflevector <4 x float> %a, <4 x float> undef, <2 x i32> <i32 1, i32 3>
  %add = fadd <2 x float> %a02, %a13
  %hadd = shufflevector <2 x float> %add, <2 x float> undef, <4 x i32> <i32 undef, i32 undef, i32 0, i32 1>
  ret <4 x float> %hadd
}

