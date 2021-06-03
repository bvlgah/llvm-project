#include "ockl.h"
#include "irif.h"

#define ATTR2 __attribute__((always_inline))
ATTR2 void
__atomic_work_item_fence(cl_mem_fence_flags flags, memory_order order, memory_scope scope)
{
    // We're tying global-happens-before and local-happens-before together as does HSA
    if (order != memory_order_relaxed) {
        switch (scope) {
        case memory_scope_work_item:
            break;
        case memory_scope_sub_group:
            switch (order) {
            case memory_order_relaxed: break;
            case memory_order_acquire: __builtin_amdgcn_fence(__ATOMIC_ACQUIRE, "wavefront"); break;
            case memory_order_release: __builtin_amdgcn_fence(__ATOMIC_RELEASE, "wavefront"); break;
            case memory_order_acq_rel: __builtin_amdgcn_fence(__ATOMIC_ACQ_REL, "wavefront"); break;
            case memory_order_seq_cst: __builtin_amdgcn_fence(__ATOMIC_SEQ_CST, "wavefront"); break;
            }
            break;
        case memory_scope_work_group:
            switch (order) {
            case memory_order_relaxed: break;
            case memory_order_acquire: __builtin_amdgcn_fence(__ATOMIC_ACQUIRE, "workgroup"); break;
            case memory_order_release: __builtin_amdgcn_fence(__ATOMIC_RELEASE, "workgroup"); break;
            case memory_order_acq_rel: __builtin_amdgcn_fence(__ATOMIC_ACQ_REL, "workgroup"); break;
            case memory_order_seq_cst: __builtin_amdgcn_fence(__ATOMIC_SEQ_CST, "workgroup"); break;
            }
            break;
        case memory_scope_device:
            switch (order) {
            case memory_order_relaxed: break;
            case memory_order_acquire: __builtin_amdgcn_fence(__ATOMIC_ACQUIRE, "agent"); break;
            case memory_order_release: __builtin_amdgcn_fence(__ATOMIC_RELEASE, "agent"); break;
            case memory_order_acq_rel: __builtin_amdgcn_fence(__ATOMIC_ACQ_REL, "agent"); break;
            case memory_order_seq_cst: __builtin_amdgcn_fence(__ATOMIC_SEQ_CST, "agent"); break;
            }
            break;
        case memory_scope_all_svm_devices:
            switch (order) {
            case memory_order_relaxed: break;
            case memory_order_acquire: __builtin_amdgcn_fence(__ATOMIC_ACQUIRE, ""); break;
            case memory_order_release: __builtin_amdgcn_fence(__ATOMIC_RELEASE, ""); break;
            case memory_order_acq_rel: __builtin_amdgcn_fence(__ATOMIC_ACQ_REL, ""); break;
            case memory_order_seq_cst: __builtin_amdgcn_fence(__ATOMIC_SEQ_CST, ""); break;
            }
            break;
        }
    }
}
