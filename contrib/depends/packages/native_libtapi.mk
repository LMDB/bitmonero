package=native_libtapi
$(package)_version=664b8414f89612f2dfd35a9b679c345aa5389026
$(package)_download_path=https://github.com/tpoechtrager/apple-libtapi/archive
$(package)_download_file=$($(package)_version).tar.gz
$(package)_file_name=$(package)-$($(package)_version).tar.gz
$(package)_sha256_hash=62e419c12d1c9fad67cc1cd523132bc00db050998337c734c15bc8d73cc02b61
$(package)_build_subdir=libtapi

define $(package)_config_cmds
  mkdir build; cd build; echo -n $(build_prefix) > INSTALLPREFIX; \
    cmake -DCMAKE_INSTALL_PREFIX=$(build_prefix) \
    -DLLVM_INCLUDE_TESTS=OFF \
	-DCMAKE_BUILD_TYPR=RELEASE \
	-DTAPI_REPOSITORY_STRING="1100.0.11" \
	-DTAPI_FULL_VERSION="11.0.0" \
	-DCMAKE_CXX_FLAGS="-I $($(package)_extract_dir)/src/llvm/projects/clang/include -I $PWD/build/projects/clang/include" \
	$($(package)_extract_dir)/src/llvm
endef

define $(package)_build_cmds
  cd build; $(MAKE)
endef

define $(package)_stage_cmds
  cd build; $(MAKE) DESTDIR=$($(package)_staging_dir) install
endef
