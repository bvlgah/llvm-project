; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=arm-none-eabi -mattr=+neon | FileCheck %s --check-prefix=CHECK

declare half @llvm.vector.reduce.fadd.f16.v1f16(half, <1 x half>)
declare float @llvm.vector.reduce.fadd.f32.v1f32(float, <1 x float>)
declare double @llvm.vector.reduce.fadd.f64.v1f64(double, <1 x double>)
declare fp128 @llvm.vector.reduce.fadd.f128.v1f128(fp128, <1 x fp128>)

declare float @llvm.vector.reduce.fadd.f32.v3f32(float, <3 x float>)
declare float @llvm.vector.reduce.fadd.f32.v5f32(float, <5 x float>)
declare fp128 @llvm.vector.reduce.fadd.f128.v2f128(fp128, <2 x fp128>)
declare float @llvm.vector.reduce.fadd.f32.v16f32(float, <16 x float>)

define half @test_v1f16(<1 x half> %a, half %s) nounwind {
; CHECK-LABEL: test_v1f16:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r4, r5, r11, lr}
; CHECK-NEXT:    push {r4, r5, r11, lr}
; CHECK-NEXT:    .vsave {d8}
; CHECK-NEXT:    vpush {d8}
; CHECK-NEXT:    mov r4, r0
; CHECK-NEXT:    mov r0, r1
; CHECK-NEXT:    bl __aeabi_h2f
; CHECK-NEXT:    mov r5, r0
; CHECK-NEXT:    mov r0, r4
; CHECK-NEXT:    bl __aeabi_f2h
; CHECK-NEXT:    vmov s16, r5
; CHECK-NEXT:    bl __aeabi_h2f
; CHECK-NEXT:    vmov s0, r0
; CHECK-NEXT:    vadd.f32 s0, s16, s0
; CHECK-NEXT:    vmov r0, s0
; CHECK-NEXT:    bl __aeabi_f2h
; CHECK-NEXT:    vpop {d8}
; CHECK-NEXT:    pop {r4, r5, r11, lr}
; CHECK-NEXT:    mov pc, lr
  %b = call half @llvm.vector.reduce.fadd.f16.v1f16(half %s, <1 x half> %a)
  ret half %b
}

define half @test_v1f16_neutral(<1 x half> %a) nounwind {
; CHECK-LABEL: test_v1f16_neutral:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r11, lr}
; CHECK-NEXT:    push {r11, lr}
; CHECK-NEXT:    bl __aeabi_f2h
; CHECK-NEXT:    mov r1, #255
; CHECK-NEXT:    orr r1, r1, #65280
; CHECK-NEXT:    and r0, r0, r1
; CHECK-NEXT:    pop {r11, lr}
; CHECK-NEXT:    mov pc, lr
  %b = call half @llvm.vector.reduce.fadd.f16.v1f16(half -0.0, <1 x half> %a)
  ret half %b
}

define float @test_v1f32(<1 x float> %a, float %s) nounwind {
; CHECK-LABEL: test_v1f32:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vmov s0, r0
; CHECK-NEXT:    vmov s2, r1
; CHECK-NEXT:    vadd.f32 s0, s2, s0
; CHECK-NEXT:    vmov r0, s0
; CHECK-NEXT:    mov pc, lr
  %b = call float @llvm.vector.reduce.fadd.f32.v1f32(float %s, <1 x float> %a)
  ret float %b
}

define float @test_v1f32_neutral(<1 x float> %a) nounwind {
; CHECK-LABEL: test_v1f32_neutral:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    mov pc, lr
  %b = call float @llvm.vector.reduce.fadd.f32.v1f32(float -0.0, <1 x float> %a)
  ret float %b
}

define double @test_v1f64(<1 x double> %a, double %s) nounwind {
; CHECK-LABEL: test_v1f64:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vmov d16, r0, r1
; CHECK-NEXT:    vmov d17, r2, r3
; CHECK-NEXT:    vadd.f64 d16, d17, d16
; CHECK-NEXT:    vmov r0, r1, d16
; CHECK-NEXT:    mov pc, lr
  %b = call double @llvm.vector.reduce.fadd.f64.v1f64(double %s, <1 x double> %a)
  ret double %b
}

define double @test_v1f64_neutral(<1 x double> %a) nounwind {
; CHECK-LABEL: test_v1f64_neutral:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    mov pc, lr
  %b = call double @llvm.vector.reduce.fadd.f64.v1f64(double -0.0, <1 x double> %a)
  ret double %b
}

define fp128 @test_v1f128(<1 x fp128> %a, fp128 %s) nounwind {
; CHECK-LABEL: test_v1f128:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r4, r5, r11, lr}
; CHECK-NEXT:    push {r4, r5, r11, lr}
; CHECK-NEXT:    .pad #16
; CHECK-NEXT:    sub sp, sp, #16
; CHECK-NEXT:    ldr r12, [sp, #32]
; CHECK-NEXT:    ldr lr, [sp, #36]
; CHECK-NEXT:    ldr r4, [sp, #40]
; CHECK-NEXT:    ldr r5, [sp, #44]
; CHECK-NEXT:    stm sp, {r0, r1, r2, r3}
; CHECK-NEXT:    mov r0, r12
; CHECK-NEXT:    mov r1, lr
; CHECK-NEXT:    mov r2, r4
; CHECK-NEXT:    mov r3, r5
; CHECK-NEXT:    bl __addtf3
; CHECK-NEXT:    add sp, sp, #16
; CHECK-NEXT:    pop {r4, r5, r11, lr}
; CHECK-NEXT:    mov pc, lr
  %b = call fp128 @llvm.vector.reduce.fadd.f128.v1f128(fp128 %s, <1 x fp128> %a)
  ret fp128 %b
}

define fp128 @test_v1f128_neutral(<1 x fp128> %a) nounwind {
; CHECK-LABEL: test_v1f128_neutral:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    mov pc, lr
  %b = call fp128 @llvm.vector.reduce.fadd.f128.v1f128(fp128 0xL00000000000000008000000000000000, <1 x fp128> %a)
  ret fp128 %b
}

define float @test_v3f32(<3 x float> %a, float %s) nounwind {
; CHECK-LABEL: test_v3f32:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vmov d3, r2, r3
; CHECK-NEXT:    vldr s0, [sp]
; CHECK-NEXT:    vmov d2, r0, r1
; CHECK-NEXT:    vadd.f32 s0, s0, s4
; CHECK-NEXT:    vadd.f32 s0, s0, s5
; CHECK-NEXT:    vadd.f32 s0, s0, s6
; CHECK-NEXT:    vmov r0, s0
; CHECK-NEXT:    mov pc, lr
  %b = call float @llvm.vector.reduce.fadd.f32.v3f32(float %s, <3 x float> %a)
  ret float %b
}

define float @test_v3f32_neutral(<3 x float> %a) nounwind {
; CHECK-LABEL: test_v3f32_neutral:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vmov d1, r2, r3
; CHECK-NEXT:    vmov d0, r0, r1
; CHECK-NEXT:    vadd.f32 s4, s0, s1
; CHECK-NEXT:    vadd.f32 s0, s4, s2
; CHECK-NEXT:    vmov r0, s0
; CHECK-NEXT:    mov pc, lr
  %b = call float @llvm.vector.reduce.fadd.f32.v3f32(float -0.0, <3 x float> %a)
  ret float %b
}

define float @test_v5f32(<5 x float> %a, float %s) nounwind {
; CHECK-LABEL: test_v5f32:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr s0, [sp, #4]
; CHECK-NEXT:    vmov s2, r0
; CHECK-NEXT:    vadd.f32 s0, s0, s2
; CHECK-NEXT:    vmov s2, r1
; CHECK-NEXT:    vadd.f32 s0, s0, s2
; CHECK-NEXT:    vmov s2, r2
; CHECK-NEXT:    vadd.f32 s0, s0, s2
; CHECK-NEXT:    vmov s2, r3
; CHECK-NEXT:    vadd.f32 s0, s0, s2
; CHECK-NEXT:    vldr s2, [sp]
; CHECK-NEXT:    vadd.f32 s0, s0, s2
; CHECK-NEXT:    vmov r0, s0
; CHECK-NEXT:    mov pc, lr
  %b = call float @llvm.vector.reduce.fadd.f32.v5f32(float %s, <5 x float> %a)
  ret float %b
}

define float @test_v5f32_neutral(<5 x float> %a) nounwind {
; CHECK-LABEL: test_v5f32_neutral:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vmov s0, r1
; CHECK-NEXT:    vmov s2, r0
; CHECK-NEXT:    vadd.f32 s0, s2, s0
; CHECK-NEXT:    vmov s2, r2
; CHECK-NEXT:    vadd.f32 s0, s0, s2
; CHECK-NEXT:    vmov s2, r3
; CHECK-NEXT:    vadd.f32 s0, s0, s2
; CHECK-NEXT:    vldr s2, [sp]
; CHECK-NEXT:    vadd.f32 s0, s0, s2
; CHECK-NEXT:    vmov r0, s0
; CHECK-NEXT:    mov pc, lr
  %b = call float @llvm.vector.reduce.fadd.f32.v5f32(float -0.0, <5 x float> %a)
  ret float %b
}

define fp128 @test_v2f128(<2 x fp128> %a, fp128 %s) nounwind {
; CHECK-LABEL: test_v2f128:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r4, r5, r11, lr}
; CHECK-NEXT:    push {r4, r5, r11, lr}
; CHECK-NEXT:    .pad #16
; CHECK-NEXT:    sub sp, sp, #16
; CHECK-NEXT:    ldr r12, [sp, #48]
; CHECK-NEXT:    ldr lr, [sp, #52]
; CHECK-NEXT:    ldr r4, [sp, #56]
; CHECK-NEXT:    ldr r5, [sp, #60]
; CHECK-NEXT:    stm sp, {r0, r1, r2, r3}
; CHECK-NEXT:    mov r0, r12
; CHECK-NEXT:    mov r1, lr
; CHECK-NEXT:    mov r2, r4
; CHECK-NEXT:    mov r3, r5
; CHECK-NEXT:    bl __addtf3
; CHECK-NEXT:    ldr r4, [sp, #32]
; CHECK-NEXT:    ldr r5, [sp, #40]
; CHECK-NEXT:    ldr lr, [sp, #44]
; CHECK-NEXT:    ldr r12, [sp, #36]
; CHECK-NEXT:    stm sp, {r4, r12}
; CHECK-NEXT:    str r5, [sp, #8]
; CHECK-NEXT:    str lr, [sp, #12]
; CHECK-NEXT:    bl __addtf3
; CHECK-NEXT:    add sp, sp, #16
; CHECK-NEXT:    pop {r4, r5, r11, lr}
; CHECK-NEXT:    mov pc, lr
  %b = call fp128 @llvm.vector.reduce.fadd.f128.v2f128(fp128 %s, <2 x fp128> %a)
  ret fp128 %b
}

define fp128 @test_v2f128_neutral(<2 x fp128> %a) nounwind {
; CHECK-LABEL: test_v2f128_neutral:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    .save {r4, r5, r11, lr}
; CHECK-NEXT:    push {r4, r5, r11, lr}
; CHECK-NEXT:    .pad #16
; CHECK-NEXT:    sub sp, sp, #16
; CHECK-NEXT:    ldr r12, [sp, #36]
; CHECK-NEXT:    ldr lr, [sp, #32]
; CHECK-NEXT:    ldr r4, [sp, #40]
; CHECK-NEXT:    ldr r5, [sp, #44]
; CHECK-NEXT:    str lr, [sp]
; CHECK-NEXT:    str r12, [sp, #4]
; CHECK-NEXT:    str r4, [sp, #8]
; CHECK-NEXT:    str r5, [sp, #12]
; CHECK-NEXT:    bl __addtf3
; CHECK-NEXT:    add sp, sp, #16
; CHECK-NEXT:    pop {r4, r5, r11, lr}
; CHECK-NEXT:    mov pc, lr
  %b = call fp128 @llvm.vector.reduce.fadd.f128.v2f128(fp128 0xL00000000000000008000000000000000, <2 x fp128> %a)
  ret fp128 %b
}

define float @test_v16f32(<16 x float> %a, float %s) nounwind {
; CHECK-LABEL: test_v16f32:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vmov d3, r2, r3
; CHECK-NEXT:    vldr s0, [sp, #48]
; CHECK-NEXT:    vmov d2, r0, r1
; CHECK-NEXT:    mov r0, sp
; CHECK-NEXT:    vadd.f32 s0, s0, s4
; CHECK-NEXT:    vadd.f32 s0, s0, s5
; CHECK-NEXT:    vadd.f32 s0, s0, s6
; CHECK-NEXT:    vadd.f32 s0, s0, s7
; CHECK-NEXT:    vld1.64 {d2, d3}, [r0]
; CHECK-NEXT:    add r0, sp, #16
; CHECK-NEXT:    vadd.f32 s0, s0, s4
; CHECK-NEXT:    vadd.f32 s0, s0, s5
; CHECK-NEXT:    vadd.f32 s0, s0, s6
; CHECK-NEXT:    vadd.f32 s0, s0, s7
; CHECK-NEXT:    vld1.64 {d2, d3}, [r0]
; CHECK-NEXT:    add r0, sp, #32
; CHECK-NEXT:    vadd.f32 s0, s0, s4
; CHECK-NEXT:    vadd.f32 s0, s0, s5
; CHECK-NEXT:    vadd.f32 s0, s0, s6
; CHECK-NEXT:    vadd.f32 s0, s0, s7
; CHECK-NEXT:    vld1.64 {d2, d3}, [r0]
; CHECK-NEXT:    vadd.f32 s0, s0, s4
; CHECK-NEXT:    vadd.f32 s0, s0, s5
; CHECK-NEXT:    vadd.f32 s0, s0, s6
; CHECK-NEXT:    vadd.f32 s0, s0, s7
; CHECK-NEXT:    vmov r0, s0
; CHECK-NEXT:    mov pc, lr
  %b = call float @llvm.vector.reduce.fadd.f32.v16f32(float %s, <16 x float> %a)
  ret float %b
}

define float @test_v16f32_neutral(<16 x float> %a) nounwind {
; CHECK-LABEL: test_v16f32_neutral:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vmov d1, r2, r3
; CHECK-NEXT:    vmov d0, r0, r1
; CHECK-NEXT:    mov r0, sp
; CHECK-NEXT:    vadd.f32 s4, s0, s1
; CHECK-NEXT:    vadd.f32 s4, s4, s2
; CHECK-NEXT:    vadd.f32 s0, s4, s3
; CHECK-NEXT:    vld1.64 {d2, d3}, [r0]
; CHECK-NEXT:    add r0, sp, #16
; CHECK-NEXT:    vadd.f32 s0, s0, s4
; CHECK-NEXT:    vadd.f32 s0, s0, s5
; CHECK-NEXT:    vadd.f32 s0, s0, s6
; CHECK-NEXT:    vadd.f32 s0, s0, s7
; CHECK-NEXT:    vld1.64 {d2, d3}, [r0]
; CHECK-NEXT:    add r0, sp, #32
; CHECK-NEXT:    vadd.f32 s0, s0, s4
; CHECK-NEXT:    vadd.f32 s0, s0, s5
; CHECK-NEXT:    vadd.f32 s0, s0, s6
; CHECK-NEXT:    vadd.f32 s0, s0, s7
; CHECK-NEXT:    vld1.64 {d2, d3}, [r0]
; CHECK-NEXT:    vadd.f32 s0, s0, s4
; CHECK-NEXT:    vadd.f32 s0, s0, s5
; CHECK-NEXT:    vadd.f32 s0, s0, s6
; CHECK-NEXT:    vadd.f32 s0, s0, s7
; CHECK-NEXT:    vmov r0, s0
; CHECK-NEXT:    mov pc, lr
  %b = call float @llvm.vector.reduce.fadd.f32.v16f32(float -0.0, <16 x float> %a)
  ret float %b
}
