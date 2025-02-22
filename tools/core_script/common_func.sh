#!/usr/bin/env bash

# 自定义 JSON 序列化
# 删除 pb go 目标文件中的 omitempty 标签
custom_json_serialization() {
  target_file_dir=${1:?target_file_dir param is missing}
  target_file_rp=${2:?target_file_relative_path is missing}

  target_file_path="${target_file_dir}/${target_file_rp}"
  temp_file_path="${target_file_path}.temp"

  sed 's/,omitempty//g' "${target_file_path}" >"${temp_file_path}"
  rm -rf "${target_file_path}" && mv "${temp_file_path}" "${target_file_path}"
  echo "Custom JSON serialization: ${target_file_rp}"
}
