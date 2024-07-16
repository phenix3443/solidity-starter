#!/bin/bash

# 删除子模块目录
rm -rf lib/"$1"

# 从 .gitmodules 文件中移除子模块条目
# 编辑 .gitmodules 文件，删除相关条目

# 从 Git 配置中移除子模块
git rm --cached lib/"$1"

# 从 Git 配置中移除子模块的相关条目
git config -f .git/config --remove-section submodule.lib/"$1"

# 删除子模块的残留数据
rm -rf .git/modules/lib/"$1"
