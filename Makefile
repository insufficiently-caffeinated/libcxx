# This could just be a shell or bash script but I'm fine with this
.PHONY: all
all:
	git submodule init
	git submodule update
	cd llvm-project && \
	mkdir build || true && \
	cmake -G Ninja -S llvm -B build \
	-DLIBCXXABI_ENABLE_EXCEPTIONS=OFF \
	-DLIBCXX_ENABLE_EXCEPTIONS=OFF \
	-DLIBCXX_ENABLE_THREADS=OFF \
	-DLIBCXX_HAS_PTHREAD_API=OFF \
	-DLLVM_ENABLE_THREADS=OFF \
	-DLIBCXXABI_ENABLE_THREADS=OFF \
	-DLIBCXXABI_HAS_PTHREAD_API=OFF \
	-DLIBCXXABI_HAS_WIN32_THREAD_API=OFF \
	-DLIBCXXABI_HAS_EXTERNAL_THREAD_API=OFF \
	-DLIBCXXABI_BUILD_EXTERNAL_THREAD_LIBRARY=OFF \
	-DLLVM_ENABLE_PROJECTS="libcxx;libcxxabi" -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=gclang -DCMAKE_CXX_COMPILER=gclang++ && \
	ninja -C build cxx cxxabi
	mkdir -p build/bca || true
	get-bc -o build/bca/libcxx.bca llvm-project/build/lib/libc++.a
	get-bc -o build/bca/libcxxabi.bca llvm-project/build/lib/libc++abi.a
	mkdir ll || true
	cd ll && llvm-ar -x ../build/bca/libcxx.bca
	cd ll && llvm-ar -x ../build/bca/libcxxabi.bca
	llvm-link ll/.*.bc -o ll/libcxx.temp
	rm ll/.*.bc
	mv ll/libcxx.temp ll/libcxx.bc
