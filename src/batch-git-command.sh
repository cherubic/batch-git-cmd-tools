#!/bin/bash
set -x

script="batch-git-command"

config_path="" # yaml配置目录
git_branch=""   # git checkout branch
git_new_branch=""   # git创建的新分支
common_config_path=""   # 需要修改的通用配置路径


function modify_common_config() {
    echo "not impletement"
}

function new_branch() {
    
    repos_number=$(yq e '.newbranch | length' "${config_path}")

    for ((i=0; i < repos_number; i++))
    do
        local git_repo
        git_repo=$(yq e ".newbranch[${i}].repo" "${config_path}")

        git clone "${git_repo}"

        local repo_local_path
        repo_local_path=$(echo "${git_repo}" | grep -o -P "(?<=\/).*?(?=\.git)")

        local git_branch_item="${git_branch}"

        if [[ -n $(yq e ".newbranch[${i}].branch" "${config_path}") ]]; then
            git_branch_item=$(yq e ".newbranch[${i}].branch" "${config_path}")
        fi

        local git_new_branch_item="${git_new_branch}"

        if [[ -n $(yq e ".newbranch[${i}].newbranch" "${config_path}") ]]; then
            git_new_branch_item=$(yq e ".newbranch[${i}].newbranch" "${config_path}")
        fi

        pushd "${repo_local_path}" || exit 1

        git checkout "${git_branch_item}"

        git branch "${git_new_branch_item}"

        git checkout "${git_new_branch_item}"

        git push --set-upstream origin "${git_new_branch_item}"

        popd || exit 1
    done
}

function example() {
    echo -e "usage: ${script} -cp /new_branch.yaml -br master -nbr example"
}

function usage() {
    echo -e "usage: ${script} -cp <config-file> -br <origin-branch> -nbr <new>"
}

function help() {
    usage

}

function main() {
    while [ "$1" != "" ]; do
        case $1 in
        -cp | --config-path)
            shift
            config_path=$1
            ;;
        -br | --git-branch)
            shift
            git_branch=$1
            ;;
        -nbr | --git-new-branch)
            shift
            git_new_branch=$1
            ;;
        -ccp | --common-config-path)
            shift
            common_config_path=$1
            ;;
        -o | --option)
            shift
            option=$1
            ;;
        -h | --help)
            help
            exit
            ;;
        # *)
        #     echo "$script: illegal option $1"
        #     usage
        #     example
        #     exit 1 # error
        #     ;;
        esac
        shift
    done

    if [[ $option = "newbranch" ]]; then
        new_branch
    elif [[ $option = "changeconfig" ]]; then
        modify_common_config
    fi
}

main "$@"
