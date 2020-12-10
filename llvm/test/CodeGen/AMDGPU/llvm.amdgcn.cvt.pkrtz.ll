; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -march=amdgcn -verify-machineinstrs < %s | FileCheck %s -enable-var-scope -check-prefixes=GCN,SI
; RUN: llc -march=amdgcn -mcpu=fiji -verify-machineinstrs < %s | FileCheck %s -enable-var-scope -check-prefixes=GCN,GFX89,VI
; RUN: llc -march=amdgcn -mcpu=gfx900 -verify-machineinstrs < %s | FileCheck %s -enable-var-scope -check-prefixes=GCN,GFX89,GFX9

define amdgpu_kernel void @s_cvt_pkrtz_v2f16_f32(<2 x half> addrspace(1)* %out, float %x, float %y) #0 {
; SI-LABEL: s_cvt_pkrtz_v2f16_f32:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0xb
; SI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    v_mov_b32_e32 v0, s5
; SI-NEXT:    v_cvt_pkrtz_f16_f32_e32 v0, s4, v0
; SI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: s_cvt_pkrtz_v2f16_f32:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; VI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x2c
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s1
; VI-NEXT:    v_cvt_pkrtz_f16_f32 v2, s0, v0
; VI-NEXT:    v_mov_b32_e32 v0, s2
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    flat_store_dword v[0:1], v2
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: s_cvt_pkrtz_v2f16_f32:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GFX9-NEXT:    s_load_dwordx2 s[4:5], s[0:1], 0x2c
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    v_mov_b32_e32 v1, s5
; GFX9-NEXT:    v_cvt_pkrtz_f16_f32 v1, s4, v1
; GFX9-NEXT:    global_store_dword v0, v1, s[2:3]
; GFX9-NEXT:    s_endpgm
  %result = call <2 x half> @llvm.amdgcn.cvt.pkrtz(float %x, float %y)
  store <2 x half> %result, <2 x half> addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @s_cvt_pkrtz_samereg_v2f16_f32(<2 x half> addrspace(1)* %out, float %x) #0 {
; SI-LABEL: s_cvt_pkrtz_samereg_v2f16_f32:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dword s4, s[0:1], 0xb
; SI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s3, 0xf000
; SI-NEXT:    s_mov_b32 s2, -1
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    v_cvt_pkrtz_f16_f32_e64 v0, s4, s4
; SI-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; SI-NEXT:    s_endpgm
;
; VI-LABEL: s_cvt_pkrtz_samereg_v2f16_f32:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; VI-NEXT:    s_load_dword s0, s[0:1], 0x2c
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v0, s2
; VI-NEXT:    v_cvt_pkrtz_f16_f32 v2, s0, s0
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    flat_store_dword v[0:1], v2
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: s_cvt_pkrtz_samereg_v2f16_f32:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x24
; GFX9-NEXT:    s_load_dword s4, s[0:1], 0x2c
; GFX9-NEXT:    v_mov_b32_e32 v0, 0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    v_cvt_pkrtz_f16_f32 v1, s4, s4
; GFX9-NEXT:    global_store_dword v0, v1, s[2:3]
; GFX9-NEXT:    s_endpgm
  %result = call <2 x half> @llvm.amdgcn.cvt.pkrtz(float %x, float %x)
  store <2 x half> %result, <2 x half> addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @s_cvt_pkrtz_undef_undef(<2 x half> addrspace(1)* %out) #0 {
; GCN-LABEL: s_cvt_pkrtz_undef_undef:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_endpgm
  %result = call <2 x half> @llvm.amdgcn.cvt.pkrtz(float undef, float undef)
  store <2 x half> %result, <2 x half> addrspace(1)* %out
  ret void
}

define amdgpu_kernel void @v_cvt_pkrtz_v2f16_f32(<2 x half> addrspace(1)* %out, float addrspace(1)* %a.ptr, float addrspace(1)* %b.ptr) #0 {
; SI-LABEL: v_cvt_pkrtz_v2f16_f32:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x9
; SI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0xd
; SI-NEXT:    s_mov_b32 s11, 0xf000
; SI-NEXT:    s_mov_b32 s10, 0
; SI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; SI-NEXT:    v_mov_b32_e32 v1, 0
; SI-NEXT:    s_mov_b64 s[2:3], s[10:11]
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[6:7]
; SI-NEXT:    buffer_load_dword v2, v[0:1], s[8:11], 0 addr64
; SI-NEXT:    buffer_load_dword v3, v[0:1], s[0:3], 0 addr64
; SI-NEXT:    s_mov_b64 s[6:7], s[10:11]
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_cvt_pkrtz_f16_f32_e32 v2, v2, v3
; SI-NEXT:    buffer_store_dword v2, v[0:1], s[4:7], 0 addr64
; SI-NEXT:    s_endpgm
;
; VI-LABEL: v_cvt_pkrtz_v2f16_f32:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x34
; VI-NEXT:    v_lshlrev_b32_e32 v4, 2, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s7
; VI-NEXT:    v_add_u32_e32 v0, vcc, s6, v4
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    v_mov_b32_e32 v3, s1
; VI-NEXT:    v_add_u32_e32 v2, vcc, s0, v4
; VI-NEXT:    v_addc_u32_e32 v3, vcc, 0, v3, vcc
; VI-NEXT:    flat_load_dword v0, v[0:1]
; VI-NEXT:    flat_load_dword v1, v[2:3]
; VI-NEXT:    v_mov_b32_e32 v5, s5
; VI-NEXT:    v_add_u32_e32 v4, vcc, s4, v4
; VI-NEXT:    v_addc_u32_e32 v5, vcc, 0, v5, vcc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_cvt_pkrtz_f16_f32 v0, v0, v1
; VI-NEXT:    flat_store_dword v[4:5], v0
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: v_cvt_pkrtz_v2f16_f32:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX9-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x34
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v1, v0, s[6:7]
; GFX9-NEXT:    global_load_dword v2, v0, s[2:3]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_cvt_pkrtz_f16_f32 v1, v1, v2
; GFX9-NEXT:    global_store_dword v0, v1, s[4:5]
; GFX9-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %tid.ext = sext i32 %tid to i64
  %a.gep = getelementptr inbounds float, float addrspace(1)* %a.ptr, i64 %tid.ext
  %b.gep = getelementptr inbounds float, float addrspace(1)* %b.ptr, i64 %tid.ext
  %out.gep = getelementptr inbounds <2 x half>, <2 x half> addrspace(1)* %out, i64 %tid.ext
  %a = load volatile float, float addrspace(1)* %a.gep
  %b = load volatile float, float addrspace(1)* %b.gep
  %cvt = call <2 x half> @llvm.amdgcn.cvt.pkrtz(float %a, float %b)
  store <2 x half> %cvt, <2 x half> addrspace(1)* %out.gep
  ret void
}

define amdgpu_kernel void @v_cvt_pkrtz_v2f16_f32_reg_imm(<2 x half> addrspace(1)* %out, float addrspace(1)* %a.ptr) #0 {
; SI-LABEL: v_cvt_pkrtz_v2f16_f32_reg_imm:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s6, 0
; SI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; SI-NEXT:    v_mov_b32_e32 v1, 0
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b64 s[4:5], s[2:3]
; SI-NEXT:    buffer_load_dword v2, v[0:1], s[4:7], 0 addr64
; SI-NEXT:    s_mov_b64 s[2:3], s[6:7]
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_cvt_pkrtz_f16_f32_e64 v2, v2, 1.0
; SI-NEXT:    buffer_store_dword v2, v[0:1], s[0:3], 0 addr64
; SI-NEXT:    s_endpgm
;
; VI-LABEL: v_cvt_pkrtz_v2f16_f32_reg_imm:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, s2, v2
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dword v0, v[0:1]
; VI-NEXT:    v_mov_b32_e32 v3, s1
; VI-NEXT:    v_add_u32_e32 v2, vcc, s0, v2
; VI-NEXT:    v_addc_u32_e32 v3, vcc, 0, v3, vcc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_cvt_pkrtz_f16_f32 v0, v0, 1.0
; VI-NEXT:    flat_store_dword v[2:3], v0
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: v_cvt_pkrtz_v2f16_f32_reg_imm:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v1, v0, s[2:3]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_cvt_pkrtz_f16_f32 v1, v1, 1.0
; GFX9-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %tid.ext = sext i32 %tid to i64
  %a.gep = getelementptr inbounds float, float addrspace(1)* %a.ptr, i64 %tid.ext
  %out.gep = getelementptr inbounds <2 x half>, <2 x half> addrspace(1)* %out, i64 %tid.ext
  %a = load volatile float, float addrspace(1)* %a.gep
  %cvt = call <2 x half> @llvm.amdgcn.cvt.pkrtz(float %a, float 1.0)
  store <2 x half> %cvt, <2 x half> addrspace(1)* %out.gep
  ret void
}

define amdgpu_kernel void @v_cvt_pkrtz_v2f16_f32_imm_reg(<2 x half> addrspace(1)* %out, float addrspace(1)* %a.ptr) #0 {
; SI-LABEL: v_cvt_pkrtz_v2f16_f32_imm_reg:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x9
; SI-NEXT:    s_mov_b32 s7, 0xf000
; SI-NEXT:    s_mov_b32 s6, 0
; SI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; SI-NEXT:    v_mov_b32_e32 v1, 0
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b64 s[4:5], s[2:3]
; SI-NEXT:    buffer_load_dword v2, v[0:1], s[4:7], 0 addr64
; SI-NEXT:    s_mov_b64 s[2:3], s[6:7]
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_cvt_pkrtz_f16_f32_e32 v2, 1.0, v2
; SI-NEXT:    buffer_store_dword v2, v[0:1], s[0:3], 0 addr64
; SI-NEXT:    s_endpgm
;
; VI-LABEL: v_cvt_pkrtz_v2f16_f32_imm_reg:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; VI-NEXT:    v_lshlrev_b32_e32 v2, 2, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s3
; VI-NEXT:    v_add_u32_e32 v0, vcc, s2, v2
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    flat_load_dword v0, v[0:1]
; VI-NEXT:    v_mov_b32_e32 v3, s1
; VI-NEXT:    v_add_u32_e32 v2, vcc, s0, v2
; VI-NEXT:    v_addc_u32_e32 v3, vcc, 0, v3, vcc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_cvt_pkrtz_f16_f32 v0, 1.0, v0
; VI-NEXT:    flat_store_dword v[2:3], v0
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: v_cvt_pkrtz_v2f16_f32_imm_reg:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[0:3], s[0:1], 0x24
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v1, v0, s[2:3]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_cvt_pkrtz_f16_f32 v1, 1.0, v1
; GFX9-NEXT:    global_store_dword v0, v1, s[0:1]
; GFX9-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %tid.ext = sext i32 %tid to i64
  %a.gep = getelementptr inbounds float, float addrspace(1)* %a.ptr, i64 %tid.ext
  %out.gep = getelementptr inbounds <2 x half>, <2 x half> addrspace(1)* %out, i64 %tid.ext
  %a = load volatile float, float addrspace(1)* %a.gep
  %cvt = call <2 x half> @llvm.amdgcn.cvt.pkrtz(float 1.0, float %a)
  store <2 x half> %cvt, <2 x half> addrspace(1)* %out.gep
  ret void
}

define amdgpu_kernel void @v_cvt_pkrtz_v2f16_f32_fneg_lo(<2 x half> addrspace(1)* %out, float addrspace(1)* %a.ptr, float addrspace(1)* %b.ptr) #0 {
; SI-LABEL: v_cvt_pkrtz_v2f16_f32_fneg_lo:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x9
; SI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0xd
; SI-NEXT:    s_mov_b32 s11, 0xf000
; SI-NEXT:    s_mov_b32 s10, 0
; SI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; SI-NEXT:    v_mov_b32_e32 v1, 0
; SI-NEXT:    s_mov_b64 s[2:3], s[10:11]
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[6:7]
; SI-NEXT:    buffer_load_dword v2, v[0:1], s[8:11], 0 addr64
; SI-NEXT:    buffer_load_dword v3, v[0:1], s[0:3], 0 addr64
; SI-NEXT:    s_mov_b64 s[6:7], s[10:11]
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_cvt_pkrtz_f16_f32_e64 v2, -v2, v3
; SI-NEXT:    buffer_store_dword v2, v[0:1], s[4:7], 0 addr64
; SI-NEXT:    s_endpgm
;
; VI-LABEL: v_cvt_pkrtz_v2f16_f32_fneg_lo:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x34
; VI-NEXT:    v_lshlrev_b32_e32 v4, 2, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s7
; VI-NEXT:    v_add_u32_e32 v0, vcc, s6, v4
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    v_mov_b32_e32 v3, s1
; VI-NEXT:    v_add_u32_e32 v2, vcc, s0, v4
; VI-NEXT:    v_addc_u32_e32 v3, vcc, 0, v3, vcc
; VI-NEXT:    flat_load_dword v0, v[0:1]
; VI-NEXT:    flat_load_dword v1, v[2:3]
; VI-NEXT:    v_mov_b32_e32 v5, s5
; VI-NEXT:    v_add_u32_e32 v4, vcc, s4, v4
; VI-NEXT:    v_addc_u32_e32 v5, vcc, 0, v5, vcc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_cvt_pkrtz_f16_f32 v0, -v0, v1
; VI-NEXT:    flat_store_dword v[4:5], v0
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: v_cvt_pkrtz_v2f16_f32_fneg_lo:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX9-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x34
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v1, v0, s[6:7]
; GFX9-NEXT:    global_load_dword v2, v0, s[2:3]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_cvt_pkrtz_f16_f32 v1, -v1, v2
; GFX9-NEXT:    global_store_dword v0, v1, s[4:5]
; GFX9-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %tid.ext = sext i32 %tid to i64
  %a.gep = getelementptr inbounds float, float addrspace(1)* %a.ptr, i64 %tid.ext
  %b.gep = getelementptr inbounds float, float addrspace(1)* %b.ptr, i64 %tid.ext
  %out.gep = getelementptr inbounds <2 x half>, <2 x half> addrspace(1)* %out, i64 %tid.ext
  %a = load volatile float, float addrspace(1)* %a.gep
  %b = load volatile float, float addrspace(1)* %b.gep
  %neg.a = fsub float -0.0, %a
  %cvt = call <2 x half> @llvm.amdgcn.cvt.pkrtz(float %neg.a, float %b)
  store <2 x half> %cvt, <2 x half> addrspace(1)* %out.gep
  ret void
}

define amdgpu_kernel void @v_cvt_pkrtz_v2f16_f32_fneg_hi(<2 x half> addrspace(1)* %out, float addrspace(1)* %a.ptr, float addrspace(1)* %b.ptr) #0 {
; SI-LABEL: v_cvt_pkrtz_v2f16_f32_fneg_hi:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x9
; SI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0xd
; SI-NEXT:    s_mov_b32 s11, 0xf000
; SI-NEXT:    s_mov_b32 s10, 0
; SI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; SI-NEXT:    v_mov_b32_e32 v1, 0
; SI-NEXT:    s_mov_b64 s[2:3], s[10:11]
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[6:7]
; SI-NEXT:    buffer_load_dword v2, v[0:1], s[8:11], 0 addr64
; SI-NEXT:    buffer_load_dword v3, v[0:1], s[0:3], 0 addr64
; SI-NEXT:    s_mov_b64 s[6:7], s[10:11]
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_cvt_pkrtz_f16_f32_e64 v2, v2, -v3
; SI-NEXT:    buffer_store_dword v2, v[0:1], s[4:7], 0 addr64
; SI-NEXT:    s_endpgm
;
; VI-LABEL: v_cvt_pkrtz_v2f16_f32_fneg_hi:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x34
; VI-NEXT:    v_lshlrev_b32_e32 v4, 2, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s7
; VI-NEXT:    v_add_u32_e32 v0, vcc, s6, v4
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    v_mov_b32_e32 v3, s1
; VI-NEXT:    v_add_u32_e32 v2, vcc, s0, v4
; VI-NEXT:    v_addc_u32_e32 v3, vcc, 0, v3, vcc
; VI-NEXT:    flat_load_dword v0, v[0:1]
; VI-NEXT:    flat_load_dword v1, v[2:3]
; VI-NEXT:    v_mov_b32_e32 v5, s5
; VI-NEXT:    v_add_u32_e32 v4, vcc, s4, v4
; VI-NEXT:    v_addc_u32_e32 v5, vcc, 0, v5, vcc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_cvt_pkrtz_f16_f32 v0, v0, -v1
; VI-NEXT:    flat_store_dword v[4:5], v0
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: v_cvt_pkrtz_v2f16_f32_fneg_hi:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX9-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x34
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v1, v0, s[6:7]
; GFX9-NEXT:    global_load_dword v2, v0, s[2:3]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_cvt_pkrtz_f16_f32 v1, v1, -v2
; GFX9-NEXT:    global_store_dword v0, v1, s[4:5]
; GFX9-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %tid.ext = sext i32 %tid to i64
  %a.gep = getelementptr inbounds float, float addrspace(1)* %a.ptr, i64 %tid.ext
  %b.gep = getelementptr inbounds float, float addrspace(1)* %b.ptr, i64 %tid.ext
  %out.gep = getelementptr inbounds <2 x half>, <2 x half> addrspace(1)* %out, i64 %tid.ext
  %a = load volatile float, float addrspace(1)* %a.gep
  %b = load volatile float, float addrspace(1)* %b.gep
  %neg.b = fsub float -0.0, %b
  %cvt = call <2 x half> @llvm.amdgcn.cvt.pkrtz(float %a, float %neg.b)
  store <2 x half> %cvt, <2 x half> addrspace(1)* %out.gep
  ret void
}

define amdgpu_kernel void @v_cvt_pkrtz_v2f16_f32_fneg_lo_hi(<2 x half> addrspace(1)* %out, float addrspace(1)* %a.ptr, float addrspace(1)* %b.ptr) #0 {
; SI-LABEL: v_cvt_pkrtz_v2f16_f32_fneg_lo_hi:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x9
; SI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0xd
; SI-NEXT:    s_mov_b32 s11, 0xf000
; SI-NEXT:    s_mov_b32 s10, 0
; SI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; SI-NEXT:    v_mov_b32_e32 v1, 0
; SI-NEXT:    s_mov_b64 s[2:3], s[10:11]
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[6:7]
; SI-NEXT:    buffer_load_dword v2, v[0:1], s[8:11], 0 addr64
; SI-NEXT:    buffer_load_dword v3, v[0:1], s[0:3], 0 addr64
; SI-NEXT:    s_mov_b64 s[6:7], s[10:11]
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_cvt_pkrtz_f16_f32_e64 v2, -v2, -v3
; SI-NEXT:    buffer_store_dword v2, v[0:1], s[4:7], 0 addr64
; SI-NEXT:    s_endpgm
;
; VI-LABEL: v_cvt_pkrtz_v2f16_f32_fneg_lo_hi:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x34
; VI-NEXT:    v_lshlrev_b32_e32 v4, 2, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s7
; VI-NEXT:    v_add_u32_e32 v0, vcc, s6, v4
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    v_mov_b32_e32 v3, s1
; VI-NEXT:    v_add_u32_e32 v2, vcc, s0, v4
; VI-NEXT:    v_addc_u32_e32 v3, vcc, 0, v3, vcc
; VI-NEXT:    flat_load_dword v0, v[0:1]
; VI-NEXT:    flat_load_dword v1, v[2:3]
; VI-NEXT:    v_mov_b32_e32 v5, s5
; VI-NEXT:    v_add_u32_e32 v4, vcc, s4, v4
; VI-NEXT:    v_addc_u32_e32 v5, vcc, 0, v5, vcc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_cvt_pkrtz_f16_f32 v0, -v0, -v1
; VI-NEXT:    flat_store_dword v[4:5], v0
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: v_cvt_pkrtz_v2f16_f32_fneg_lo_hi:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX9-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x34
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v1, v0, s[6:7]
; GFX9-NEXT:    global_load_dword v2, v0, s[2:3]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_cvt_pkrtz_f16_f32 v1, -v1, -v2
; GFX9-NEXT:    global_store_dword v0, v1, s[4:5]
; GFX9-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %tid.ext = sext i32 %tid to i64
  %a.gep = getelementptr inbounds float, float addrspace(1)* %a.ptr, i64 %tid.ext
  %b.gep = getelementptr inbounds float, float addrspace(1)* %b.ptr, i64 %tid.ext
  %out.gep = getelementptr inbounds <2 x half>, <2 x half> addrspace(1)* %out, i64 %tid.ext
  %a = load volatile float, float addrspace(1)* %a.gep
  %b = load volatile float, float addrspace(1)* %b.gep
  %neg.a = fsub float -0.0, %a
  %neg.b = fsub float -0.0, %b
  %cvt = call <2 x half> @llvm.amdgcn.cvt.pkrtz(float %neg.a, float %neg.b)
  store <2 x half> %cvt, <2 x half> addrspace(1)* %out.gep
  ret void
}

define amdgpu_kernel void @v_cvt_pkrtz_v2f16_f32_fneg_fabs_lo_fneg_hi(<2 x half> addrspace(1)* %out, float addrspace(1)* %a.ptr, float addrspace(1)* %b.ptr) #0 {
; SI-LABEL: v_cvt_pkrtz_v2f16_f32_fneg_fabs_lo_fneg_hi:
; SI:       ; %bb.0:
; SI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x9
; SI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0xd
; SI-NEXT:    s_mov_b32 s11, 0xf000
; SI-NEXT:    s_mov_b32 s10, 0
; SI-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; SI-NEXT:    v_mov_b32_e32 v1, 0
; SI-NEXT:    s_mov_b64 s[2:3], s[10:11]
; SI-NEXT:    s_waitcnt lgkmcnt(0)
; SI-NEXT:    s_mov_b64 s[8:9], s[6:7]
; SI-NEXT:    buffer_load_dword v2, v[0:1], s[8:11], 0 addr64
; SI-NEXT:    buffer_load_dword v3, v[0:1], s[0:3], 0 addr64
; SI-NEXT:    s_mov_b64 s[6:7], s[10:11]
; SI-NEXT:    s_waitcnt vmcnt(0)
; SI-NEXT:    v_cvt_pkrtz_f16_f32_e64 v2, -|v2|, -v3
; SI-NEXT:    buffer_store_dword v2, v[0:1], s[4:7], 0 addr64
; SI-NEXT:    s_endpgm
;
; VI-LABEL: v_cvt_pkrtz_v2f16_f32_fneg_fabs_lo_fneg_hi:
; VI:       ; %bb.0:
; VI-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; VI-NEXT:    s_load_dwordx2 s[0:1], s[0:1], 0x34
; VI-NEXT:    v_lshlrev_b32_e32 v4, 2, v0
; VI-NEXT:    s_waitcnt lgkmcnt(0)
; VI-NEXT:    v_mov_b32_e32 v1, s7
; VI-NEXT:    v_add_u32_e32 v0, vcc, s6, v4
; VI-NEXT:    v_addc_u32_e32 v1, vcc, 0, v1, vcc
; VI-NEXT:    v_mov_b32_e32 v3, s1
; VI-NEXT:    v_add_u32_e32 v2, vcc, s0, v4
; VI-NEXT:    v_addc_u32_e32 v3, vcc, 0, v3, vcc
; VI-NEXT:    flat_load_dword v0, v[0:1]
; VI-NEXT:    flat_load_dword v1, v[2:3]
; VI-NEXT:    v_mov_b32_e32 v5, s5
; VI-NEXT:    v_add_u32_e32 v4, vcc, s4, v4
; VI-NEXT:    v_addc_u32_e32 v5, vcc, 0, v5, vcc
; VI-NEXT:    s_waitcnt vmcnt(0)
; VI-NEXT:    v_cvt_pkrtz_f16_f32 v0, -|v0|, -v1
; VI-NEXT:    flat_store_dword v[4:5], v0
; VI-NEXT:    s_endpgm
;
; GFX9-LABEL: v_cvt_pkrtz_v2f16_f32_fneg_fabs_lo_fneg_hi:
; GFX9:       ; %bb.0:
; GFX9-NEXT:    s_load_dwordx4 s[4:7], s[0:1], 0x24
; GFX9-NEXT:    s_load_dwordx2 s[2:3], s[0:1], 0x34
; GFX9-NEXT:    v_lshlrev_b32_e32 v0, 2, v0
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    global_load_dword v1, v0, s[6:7]
; GFX9-NEXT:    global_load_dword v2, v0, s[2:3]
; GFX9-NEXT:    s_waitcnt vmcnt(0)
; GFX9-NEXT:    v_cvt_pkrtz_f16_f32 v1, -|v1|, -v2
; GFX9-NEXT:    global_store_dword v0, v1, s[4:5]
; GFX9-NEXT:    s_endpgm
  %tid = call i32 @llvm.amdgcn.workitem.id.x()
  %tid.ext = sext i32 %tid to i64
  %a.gep = getelementptr inbounds float, float addrspace(1)* %a.ptr, i64 %tid.ext
  %b.gep = getelementptr inbounds float, float addrspace(1)* %b.ptr, i64 %tid.ext
  %out.gep = getelementptr inbounds <2 x half>, <2 x half> addrspace(1)* %out, i64 %tid.ext
  %a = load volatile float, float addrspace(1)* %a.gep
  %b = load volatile float, float addrspace(1)* %b.gep
  %fabs.a = call float @llvm.fabs.f32(float %a)
  %neg.fabs.a = fsub float -0.0, %fabs.a
  %neg.b = fsub float -0.0, %b
  %cvt = call <2 x half> @llvm.amdgcn.cvt.pkrtz(float %neg.fabs.a, float %neg.b)
  store <2 x half> %cvt, <2 x half> addrspace(1)* %out.gep
  ret void
}

declare <2 x half> @llvm.amdgcn.cvt.pkrtz(float, float) #1
declare float @llvm.fabs.f32(float) #1
declare i32 @llvm.amdgcn.workitem.id.x() #1


attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }
