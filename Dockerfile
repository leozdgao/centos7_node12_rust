FROM centos:7

RUN yum install -y gcc-c++
# RUN yum install -y epel-release
# RUN yum install -y centos-release-scl
# RUN yum install -y devtoolset-8
RUN yum install -y openssl openssl-devel
RUN yum install -y fontconfig-devel

COPY CMake-3.4.3.tar.gz CMake-3.4.3.tar.gz
RUN tar -zxvf CMake-3.4.3.tar.gz

COPY llvm-project-release-6.x llvm-6.x

RUN cd CMake-3.4.3 && ./bootstrap && make && make install && \
    cd ../llvm-6.x && mkdir build && cd build && cmake -DLLVM_ENABLE_PROJECTS=clang -D_GLIBCXX_USE_CXX11_ABI=0 -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" ../llvm && \
    cmake --build . && cmake --build . --target install

# 安装 GIT
RUN yum install -y git

# 安装 Rust
RUN curl https://sh.rustup.rs -sSf > /tmp/rustup.sh
RUN sh /tmp/rustup.sh -y

# 安装 Node 和 NPM
RUN (curl -sL https://rpm.nodesource.com/setup_14.x | bash -) && yum install -y nodejs-14.0.0
