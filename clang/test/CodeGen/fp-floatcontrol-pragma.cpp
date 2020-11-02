<<<<<<< HEAD
// RUN: %clang_cc1 -triple x86_64-linux-gnu -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -DFENV_ON=1 -triple x86_64-linux-gnu -emit-llvm -o - %s | FileCheck %s
=======
// RUN: %clang_cc1 -fexperimental-strict-floating-point -DEXCEPT=1 -fcxx-exceptions -triple x86_64-linux-gnu -emit-llvm -o - %s | FileCheck -check-prefix=CHECK-NS %s
// RUN: %clang_cc1 -fexperimental-strict-floating-point -triple x86_64-linux-gnu -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -fexperimental-strict-floating-point -DFENV_ON=1 -triple x86_64-linux-gnu -emit-llvm -o - %s | FileCheck -check-prefix=CHECK-FENV %s
// RUN: %clang_cc1 -fexperimental-strict-floating-point -triple %itanium_abi_triple -O3 -emit-llvm -o - %s | FileCheck -check-prefix=CHECK-O3 %s

// Verify float_control(precise, off) enables fast math flags on fp operations.
float fp_precise_1(float a, float b, float c) {
// CHECK-O3: _Z12fp_precise_1fff
// CHECK-O3: %[[M:.+]] = fmul fast float{{.*}}
// CHECK-O3: fadd fast float %[[M]], %c
#pragma float_control(precise, off)
  return a * b + c;
}

// Is float_control state cleared on exiting compound statements?
float fp_precise_2(float a, float b, float c) {
  // CHECK-O3: _Z12fp_precise_2fff
  // CHECK-O3: %[[M:.+]] = fmul float{{.*}}
  // CHECK-O3: fadd float %[[M]], %c
  {
#pragma float_control(precise, off)
  }
  return a * b + c;
}

// Does float_control survive template instantiation?
class Foo {};
Foo operator+(Foo, Foo);

template <typename T>
T template_muladd(T a, T b, T c) {
#pragma float_control(precise, off)
  return a * b + c;
}

float fp_precise_3(float a, float b, float c) {
  // CHECK-O3: _Z12fp_precise_3fff
  // CHECK-O3: %[[M:.+]] = fmul fast float{{.*}}
  // CHECK-O3: fadd fast float %[[M]], %c
  return template_muladd<float>(a, b, c);
}

template <typename T>
class fp_precise_4 {
  float method(float a, float b, float c) {
#pragma float_control(precise, off)
    return a * b + c;
  }
};

template class fp_precise_4<int>;
// CHECK-O3: _ZN12fp_precise_4IiE6methodEfff
// CHECK-O3: %[[M:.+]] = fmul fast float{{.*}}
// CHECK-O3: fadd fast float %[[M]], %c

// Check file-scoped float_control
#pragma float_control(push)
#pragma float_control(precise, off)
float fp_precise_5(float a, float b, float c) {
  // CHECK-O3: _Z12fp_precise_5fff
  // CHECK-O3: %[[M:.+]] = fmul fast float{{.*}}
  // CHECK-O3: fadd fast float %[[M]], %c
  return a * b + c;
}
#pragma float_control(pop)
>>>>>>> b51b424c679f57dd65d83652f3e62ac2cf6de738

float fff(float x, float y) {
// CHECK-LABEL: define float @_Z3fffff{{.*}}
// CHECK: entry
#pragma float_control(except, on)
  float z;
  z = z * z;
  //CHECK: llvm.experimental.constrained.fmul{{.*}}
  {
    z = x * y;
    //CHECK: llvm.experimental.constrained.fmul{{.*}}
  }
  {
// This pragma has no effect since if there are any fp intrin in the
// function then all the operations need to be fp intrin
#pragma float_control(except, off)
    z = z + x * y;
    //CHECK: llvm.experimental.constrained.fmul{{.*}}
  }
  z = z * z;
  //CHECK: llvm.experimental.constrained.fmul{{.*}}
  return z;
}
float check_precise(float x, float y) {
  // CHECK-LABEL: define float @_Z13check_preciseff{{.*}}
  float z;
  {
#pragma float_control(precise, on)
    z = x * y + z;
    //CHECK: llvm.fmuladd{{.*}}
  }
  {
#pragma float_control(precise, off)
    z = x * y + z;
    //CHECK: fmul fast float
    //CHECK: fadd fast float
  }
  return z;
}

float fma_test1(float a, float b, float c) {
// CHECK-LABEL define float @_Z9fma_test1fff{{.*}}
#pragma float_control(precise, on)
  float x = a * b + c;
  //CHECK: fmuladd
  return x;
}

#pragma float_control(push)
#pragma float_control(precise, on)
struct Distance {};
Distance operator+(Distance, Distance);

template <class T>
T add(T lhs, T rhs) {
#pragma float_control(except, on)
  return lhs + rhs;
}
#pragma float_control(pop)

float test_OperatorCall() {
  return add(1.0f, 2.0f);
  //CHECK: llvm.experimental.constrained.fadd{{.*}}fpexcept.strict
}
// CHECK-LABEL define float  {{.*}}test_OperatorCall{{.*}}

#if FENV_ON
#pragma STDC FENV_ACCESS ON
#endif
// CHECK-LABEL: define {{.*}}callt{{.*}}

void callt() {
  volatile float z;
  z = z * z;
//CHECK-FENV: llvm.experimental.constrained.fmul{{.*}}
}
