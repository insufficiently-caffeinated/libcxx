# This could just be a shell or bash script but I'm fine with this
.PHONY: all
all:
	git submodule init
	cd llvm-project && \
	mkdir build || true && \
	cmake -G Ninja -S llvm -B build -DLLVM_ENABLE_PROJECTS="libcxx;libcxxabi" -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=gclang -DCMAKE_CXX_COMPILER=gclang++ && \
	ninja -C build cxx cxxabi
	mkdir -p build/bca || true
	get-bc -o build/bca/libcxx.bca llvm-project/build/lib/libc++.a
	get-bc -o build/bca/libcxxabi.bca llvm-project/build/lib/libc++abi.a
	mkdir ll || true
	cd ll && llvm-ar -x ../build/bca/libcxx.bca
	cd ll && llvm-ar -x ../build/bca/libcxxabi.bca
	llvm-link ll/.*.bc -o libcxx.bc
	rm ll/.*.bc
	mv libcxx.bc ll/libcxx.bc
