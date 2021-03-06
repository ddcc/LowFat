; RUN: opt < %s -cost-model -analyze -mtriple=x86_64-unknown-linux-gnu -mcpu=skylake-avx512 | FileCheck %s --check-prefix=SKX

;
; Verify the cost model for 1 src shuffles
;

; SKX-LABEL: 'test_vXf64'
define void @test_vXf64(<4 x double> %src256, <8 x double> %src512, <16 x double> %src1024) {
  ; SKX: cost of 1 {{.*}} %V256 = shufflevector
  %V256 = shufflevector <4 x double> %src256, <4 x double> undef, <4 x i32> <i32 3, i32 3, i32 1, i32 0>

  ; SKX: cost of 1 {{.*}} %V512 = shufflevector
  %V512 = shufflevector <8 x double> %src512, <8 x double> undef, <8 x i32> <i32 7, i32 6, i32 6, i32 4, i32 3, i32 2, i32 1, i32 0>

  ; SKX: cost of 2 {{.*}} %V1024 = shufflevector
  %V1024 = shufflevector <16 x double> %src1024, <16 x double> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 13, i32 11, i32 10, i32 8, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>

  ret void
}

; SKX-LABEL: 'test_vXi64'
define void @test_vXi64(<4 x i64> %src256, <8 x i64> %src512) {

  ; SKX: cost of 1 {{.*}} %V256 = shufflevector
  %V256 = shufflevector <4 x i64> %src256, <4 x i64> undef, <4 x i32> <i32 3, i32 3, i32 1, i32 0>

  ; SKX: cost of 1 {{.*}} %V512 = shufflevector
  %V512 = shufflevector <8 x i64> %src512, <8 x i64> undef, <8 x i32> <i32 7, i32 6, i32 6, i32 4, i32 3, i32 2, i32 1, i32 0>

  ret void
}

; CHECK-LABEL: 'test_vXf32'
define void @test_vXf32(<4 x float> %src128, <8 x float> %src256, <16 x float> %src512) {

  ; SKX: cost of 1 {{.*}} %V128 = shufflevector
  %V128 = shufflevector <4 x float> %src128, <4 x float> undef, <4 x i32> <i32 3, i32 3, i32 1, i32 0>

  ; SKX: cost of 1 {{.*}} %V256 = shufflevector
  %V256 = shufflevector <8 x float> %src256, <8 x float> undef, <8 x i32> <i32 7, i32 6, i32 6, i32 4, i32 3, i32 2, i32 1, i32 0>

  ; SKX: cost of 1 {{.*}} %V512 = shufflevector
  %V512 = shufflevector <16 x float> %src512, <16 x float> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 13, i32 11, i32 10, i32 8, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>

  ret void
}

; CHECK-LABEL: 'test_vXi32'
define void @test_vXi32(<4 x i32> %src128, <8 x i32> %src256, <16 x i32> %src512, <32 x i32> %src1024) {

  ; SKX: cost of 1 {{.*}} %V128 = shufflevector
  %V128 = shufflevector <4 x i32> %src128, <4 x i32> undef, <4 x i32> <i32 3, i32 3, i32 1, i32 0>

  ; SKX: cost of 1 {{.*}} %V256 = shufflevector
  %V256 = shufflevector <8 x i32> %src256, <8 x i32> undef, <8 x i32> <i32 7, i32 6, i32 5, i32 5, i32 3, i32 2, i32 1, i32 0>

  ; SKX: cost of 1 {{.*}} %V512 = shufflevector
  %V512 = shufflevector <16 x i32> %src512, <16 x i32> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 13, i32 10, i32 9, i32 8, i32 8, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>

  ; SKX: cost of 2 {{.*}} %V1024 = shufflevector
  %V1024 = shufflevector <32 x i32> %src1024, <32 x i32> undef, <32 x i32> <i32 31, i32 30, i32 20, i32 28, i32 27, i32 26, i32 25, i32 24, i32 23, i32 22, i32 21, i32 20, i32 19, i32 18, i32 17, i32 16, i32 15, i32 14, i32 13, i32 12, i32 11, i32 11, i32 9, i32 8, i32 7, i32 11, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret void
}

; CHECK-LABEL: 'test_vXi16'
define void @test_vXi16(<8 x i16> %src128, <16 x i16> %src256, <32 x i16> %src512, <64 x i16> %src1024) {

  ; SKX: cost of 1 {{.*}} %V128 = shufflevector
  %V128 = shufflevector <8 x i16> %src128, <8 x i16> undef, <8 x i32> <i32 7, i32 6, i32 6, i32 4, i32 3, i32 2, i32 1, i32 0>

  ; SKX: cost of 1 {{.*}} %V256 = shufflevector
  %V256 = shufflevector <16 x i16> %src256, <16 x i16> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 13, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>

  ; SKX: cost of 1 {{.*}} %V512 = shufflevector
  %V512 = shufflevector <32 x i16> %src512, <32 x i16> undef, <32 x i32> <i32 31, i32 30, i32 20, i32 28, i32 27, i32 26, i32 25, i32 24, i32 23, i32 22, i32 21, i32 20, i32 19, i32 18, i32 17, i32 16, i32 15, i32 14, i32 13, i32 12, i32 11, i32 11, i32 9, i32 8, i32 7, i32 11, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>

  ; SKX: cost of 2 {{.*}} %V1024 = shufflevector
  %V1024 = shufflevector <64 x i16> %src1024, <64 x i16> undef, <64 x i32> <i32 63, i32 62, i32 61, i32 60, i32 59, i32 58, i32 57, i32 56, i32 55, i32 54, i32 53, i32 52, i32 51, i32 50, i32 49, i32 48, i32 47, i32 46, i32 45, i32 44, i32 43, i32 42, i32 41, i32 40, i32 39, i32 38, i32 37, i32 36, i32 35, i32 34, i32 33, i32 32, i32 31, i32 30, i32 29, i32 28, i32 27, i32 26, i32 25, i32 24, i32 23, i32 20, i32 21, i32 20, i32 19, i32 18, i32 17, i32 16, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  ret void
}

; CHECK-LABEL: 'test_vXi8'
define void @test_vXi8(<16 x i8> %src128, <32 x i8> %src256, <64 x i8> %src512) {
  ; SKX: cost of 1 {{.*}} %V128 = shufflevector
  %V128 = shufflevector <16 x i8> %src128, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 11, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>

  ; SKX: cost of 3 {{.*}} %V256 = shufflevector
  %V256 = shufflevector <32 x i8> %src256, <32 x i8> undef, <32 x i32> <i32 31, i32 30, i32 29, i32 28, i32 27, i32 26, i32 25, i32 24, i32 23, i32 22, i32 21, i32 20, i32 19, i32 18, i32 17, i32 16, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 8, i32 8, i32 7, i32 6, i32 8, i32 4, i32 3, i32 2, i32 1, i32 0>

  ; SKX: cost of 8 {{.*}} %V512 = shufflevector
  %V512 = shufflevector <64 x i8> %src512, <64 x i8> undef, <64 x i32> <i32 63, i32 62, i32 61, i32 60, i32 59, i32 58, i32 57, i32 56, i32 55, i32 54, i32 53, i32 52, i32 51, i32 50, i32 49, i32 48, i32 47, i32 46, i32 45, i32 44, i32 43, i32 42, i32 41, i32 40, i32 39, i32 38, i32 37, i32 36, i32 35, i32 34, i32 33, i32 32, i32 31, i32 30, i32 29, i32 28, i32 27, i32 26, i32 25, i32 24, i32 23, i32 20, i32 21, i32 20, i32 19, i32 18, i32 17, i32 16, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>

  ret void
}
