#!/bin/bash
script="batch-git-command"

name="" # 服务名称
config_path="" # yaml配置目录
git_branch=""   # git checkout branch
git_new_branch=""   # git创建的新分支
common_config_path=""   # 需要修改的通用配置路径


function modify_common_config() {
    echo ""
}

function new_branch() {
    local git_repo=""


    git clone "$git_repo"

    local repo_local_path=""

    pushd "$repo_local_path" || exit 1

    local git_branch_item="$git_branch"
    local git_new_branch_item="$git_new_branch"

    

    git checkout $

    popd | exit1
    

}

function example() {
    echo ""
}

function usage() {
    echo -e "usage: $script"
}

function help() {
    usage

}

# 解析yaml
function parse() {
    echo ""
}

function main() {
    while [ "$1" != "" ]; do
        case $1 in
        -name | --name)
            shift
            marg0=$1
            ;;
        -repo | --git-repo)
            shift
            marg1=$1
            ;;
        - | --optional0)
            oarg0="true"
            ;;
        -o1 | --optional1)
            shift
            oarg1=$1
            ;;
        -h | --help)
            help
            exit
            ;;
        *)
            echo "$script: illegal option $1"
            usage
            example
            exit 1 # error
            ;;
        esac
        shift
    done
}

main "$@"
