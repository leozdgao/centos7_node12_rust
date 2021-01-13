FROM centos:7

ENV RUST_SKIA_TAG="0.33.0" 
# CMD [ "clang", "--version" ]
# ENV CXX="clang-6.0"
# ENV CPLUS_INCLUDE_PATH="/usr/include/clang/6.0.1/include"

RUN yum install -y epel-release
RUN yum install -y centos-release-scl
RUN yum install -y devtoolset-8
RUN yum install -y openssl openssl-devel

COPY cmake-3.19.2 cmake-3.19.2
COPY llvm-project-release-6.x llvm-6.x

RUN scl enable devtoolset-8 -- bash && \
    source /opt/rh/devtoolset-8/enable && \
    cd cmake-3.19.2 && ./bootstrap && make && make install && \
    cd ../llvm-6.x && mkdir build && cd build && cmake -DLLVM_ENABLE_PROJECTS=clang -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" ../llvm && \
    cmake --build . && cmake --build . --target install
# RUN cd ../llvm-6.x && mkdir build && cd build && cmake -DLLVM_ENABLE_PROJECTS=clang -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" ../llvm
# RUN cd ..
# RUN cd llvm-6.x && mkdir build && cd build && cmake -DLLVM_ENABLE_PROJECTS=clang -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" ../llvm


# 安装 GIT
# RUN yum install -y git

# 安装 Node 和 NPM
# RUN (curl -sL https://rpm.nodesource.com/setup_12.x | bash -) && yum install -y nodejs

# 安装 Rust
# RUN curl https://sh.rustup.rs -sSf > /tmp/rustup.sh
# RUN sh /tmp/rustup.sh -y
# RUN source $HOME/.cargo/env

# WORKDIR $HOME
# RUN git clone --depth 1 --branch $RUST_SKIA_TAG https://github.com/rust-skia/rust-skia.git .$HOME/rust-skia
