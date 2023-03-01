; ModuleID = 'pointer.go'
source_filename = "pointer.go"
target datalayout = "e-m:e-p:32:32-p10:8:8-p20:8:8-i64:64-n32:64-S128-ni:1:10:20"
target triple = "wasm32-unknown-wasi"

declare noalias nonnull ptr @runtime.alloc(i32, ptr, ptr) #0

declare void @runtime.trackPointer(ptr nocapture readonly, ptr, ptr) #0

; Function Attrs: nounwind
define hidden void @main.init(ptr %context) unnamed_addr #1 {
entry:
  ret void
}

; Function Attrs: nounwind
define hidden [0 x i32] @main.pointerDerefZero(ptr %x, ptr %context) unnamed_addr #1 {
entry:
  ret [0 x i32] zeroinitializer
}

; Function Attrs: nounwind
define hidden ptr @main.pointerCastFromUnsafe(ptr %x, ptr %context) unnamed_addr #1 {
entry:
  %stackalloc = alloca i8, align 1
  call void @runtime.trackPointer(ptr %x, ptr nonnull %stackalloc, ptr undef) #2
  ret ptr %x
}

; Function Attrs: nounwind
define hidden ptr @main.pointerCastToUnsafe(ptr dereferenceable_or_null(4) %x, ptr %context) unnamed_addr #1 {
entry:
  %stackalloc = alloca i8, align 1
  call void @runtime.trackPointer(ptr %x, ptr nonnull %stackalloc, ptr undef) #2
  ret ptr %x
}

; Function Attrs: nounwind
define hidden ptr @main.pointerCastToUnsafeNoop(ptr dereferenceable_or_null(1) %x, ptr %context) unnamed_addr #1 {
entry:
  %stackalloc = alloca i8, align 1
  call void @runtime.trackPointer(ptr %x, ptr nonnull %stackalloc, ptr undef) #2
  ret ptr %x
}

attributes #0 = { "target-features"="+bulk-memory,+nontrapping-fptoint,+sign-ext" }
attributes #1 = { nounwind "target-features"="+bulk-memory,+nontrapping-fptoint,+sign-ext" }
attributes #2 = { nounwind }
