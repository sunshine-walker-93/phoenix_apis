#!/usr/bin/env bash

# 拉取项目的 protobuf 依赖到 ${proto_include_dir} 目录下
export proto_include_dir="${project_dir:?is undefined}/protobuf3-include" # protobuf include 目录
echo "Get proto includes to ${proto_include_dir}"

rm -rf "${proto_include_dir}"   # 清空依赖目录
mkdir -p "${proto_include_dir}" # 新建依赖目录

# 过滤出 pb 定义的 module
filter_protobuf_module() {
  current_project_module=$(go list -m)
  awk '$1 ~ /github\.com\/lucky-cheerful-man/{print}' | awk '$1 ~ /protobuf/{print}' | grep -v
  "${current_project_module}"
}

# mkdir to hold dependencies
go list -f "{{ .Path }}" -m all | filter_protobuf_module | xargs -L1 dirname | sort | uniq |
  awk -v pi_dir="${proto_include_dir}" '{print pi_dir"/"$1}' |
  xargs mkdir -p

# cp dependencies
go list -f "{{ .Path }} {{ .Dir }}" -m all | filter_protobuf_module |
  awk -v pi_dir="${proto_include_dir}" '{print $2, pi_dir"/"$1}' |
  xargs -L1 cp -R

chmod -R u+w "${proto_include_dir}" # 依赖目录增加修改权限
