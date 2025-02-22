#!/usr/bin/env bash

# 获取当前目录
current_dir=$(cd "$(dirname "$0")" && pwd -P)
if [ -z "${current_dir}" ]; then
  echo "Get current dir failed"
  exit 1
fi

# get project base dir
export project_dir="${current_dir%/tools}"      # 项目目录
export project_tools_dir="${project_dir}/tools" # 项目工具目录

# source core script
source ./core_script/common_func.sh
source ./core_script/get_proto_include.sh
source ./core_script/wrapper_activate.sh

[ "${BASH_VERSINFO[0]}" -ge 4 ] && shopt -s globstar # 如果 bash 版本 > 4，启用 "**" 文件匹配支持

pb_source_dir="${project_dir}/protobuf3"      # pb 源码目录
pb_source_files="${pb_source_dir}/**/*.proto" # pb 源码匹配 pattern
pb_target_dir="${project_dir}/protobuf3.pb"   # pb 编译目标目录

for pb_source_path in ${pb_source_files}; do
  pb_source_rp="${pb_source_path#${pb_source_dir}/}" # pb 源码文件在源码目录的相对路径
  pb_target_rp="${pb_source_rp%.proto}.pb.go"        # pb 结果文件在目标目录的相对路径

  echo "Generate protobuf3 code, source: ${pb_source_rp}, target: ${pb_target_rp}"
  protoc -I="${wrapper_protoc_include:?is undefined}" -I="${proto_include_dir:?is undefined}" -I="${pb_source_dir}" --go_out=paths=source_relative:"${pb_target_dir}" --micro_out=paths=source_relative:"${pb_target_dir}" "${pb_source_rp}" &&
    custom_json_serialization "${pb_target_dir}" "${pb_target_rp}"
  echo
done
