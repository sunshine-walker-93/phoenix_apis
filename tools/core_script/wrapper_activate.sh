#!/usr/bin/env bash
# install protoc plugin for go and go-micro
#wget https://github.com/protocolbuffers/protobuf/releases/download/v3.11.4/protoc-3.11.4-osx-x86_64.zip
#go get google.golang.org/protobuf/cmd/protoc-gen-go
#go get github.com/micro/protoc-gen-micro

# use wrapper to build in the declared version
wrapper_dir="${project_tools_dir:?is undefined}/wrapper" # wrapper 目录
wrapper_protoc_dir="${wrapper_dir}/protoc"               # wrapper protoc 目录
wrapper_protoc_bin_dir="${wrapper_protoc_dir}/bin"       # wrapper protoc bin 目录
wrapper_go_bin_dir="${wrapper_dir}/go_bin"               # wrapper go_bin 目录

export PATH="${wrapper_protoc_bin_dir}:${wrapper_go_bin_dir}:$PATH"
export wrapper_protoc_include="${wrapper_protoc_dir}/include" # wrapper protoc include 目录

echo "Activate wrapper env in ${wrapper_dir}"
