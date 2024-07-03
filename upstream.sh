#!/usr/bin/env bash
# WARNING: This file is autogenerated - changes will be overwritten if not made via https://github.com/pulumi/ci-mgmt

set -e

original_exec="$0"
original_cmd="$1"

usage() {
  cat <<EOF
NAME
  upstream.sh - Manages applying patches to the upstream submodule.

SYNOPSIS
  ${original_exec} <init|checkout|rebase|format_patches|help> [options]

COMMANDS
  init [-f]             Initialize the upstream submodule and applies the
                        patches to the working directory.
  checkout [-f]         Create a branch in the upstream repository with the
                        patches applied as commits.
  rebase [-o] [-i]      Rebase the checked out patches.
  format_patches        Create a new set of patches from the commits in the
                        upstream repository.
  help                  Print this help message, plus examples.

OPTIONS:
  -f   Force the command to run even if the upstream submodule is modified
  -o   The new base commit to rebase the patches on top of
  -i   Run the rebase command interactively
EOF
}

docs() {
  cat <<EOF
DESCRIPTION

  We want to maintain changes to the upstream repository in a way that is easy
  to manage and track. Rather than creating a fork of the upstream repository,
  we maintain a set of patches (in the 'patches' directory) that we can apply
  directly to the upstream code in the 'upstream' submodule. Our patches are 
  never pushed to the remote upstream repository.

EXAMPLES

  Discard all changes in upstream and reapply patches to the working directory:

    ${original_exec} init -f

  Moving the patches to a new base commit:

    ${original_exec} checkout
    ${original_exec} rebase -o <new_base_commit>
    ${original_exec} format_patches

  Interactively edit the patches:

    ${original_exec} checkout
    ${original_exec} rebase -i
    ${original_exec} format_patches
EOF
}

assert_upstream_exists() {
  if [[ ! -d upstream ]]; then
    echo "No 'upstream' directory detected. Aborting."
    exit 1
  fi
}

# Check the upstream submodule isn't modified in the working tree
assert_upstream_tracked() {
  status=$(git status --porcelain upstream)
  if [[ ${status} == " M upstream" ]]; then
    current_branch=$(cd upstream && git --no-pager rev-parse --abbrev-ref HEAD)
    if [[ "${current_branch}" == "pulumi/patch-checkout" ]]; then
      cat <<EOF
Error: The 'upstream' submodule is modified with untracked changes.

Currently checked out on the 'pulumi/patch-checkout' branch. This was likely caused by
running a 'checkout' command and not running 'format_patches' afterwards.

To turn the commits in the 'pulumi/patch-checkout' branch back into patches, run the
'format_patches' command.

To disgard changes in the 'pulumi/patch-checkout' branch, use the 'force' flag (-f):

  ${original_exec} ${original_cmd} -f

EOF
      exit 1
    fi
    echo "Error: The 'upstream' submodule is modified but not tracked."
    echo "${current_branch}"
    git submodule status upstream
    cat <<EOF
Either stage or reset the 'upstream' submodule changes before continuing:

    git add upstream
    # or #
    git checkout upstream

EOF
    exit 1
  fi
}

assert_is_checked_out() {
  current_branch=$(git --no-pager rev-parse --abbrev-ref HEAD)
  if [[ "${current_branch}" != "pulumi/patch-checkout" ]]; then
    echo "Expected upstream to be checked out on the 'pulumi/patch-checkout' branch, but ${current_branch} is checked out."
    exit 1
  fi
}

err_failed_to_apply() {
  cat <<EOF

Failed to apply $1.

Hint: to avoid conflicts when updating the upstream submodule, use the
following commands:

1. 'checkout' to create a branch with the patches applied as commits
2. 'rebase' to rebase the patches on top of the new upstream commit
   - Resolve any conflicts and continue the rebase
3. 'format_patches' to create an updated set of patches from the commits

Reset the upstream submodule to the previous known good upstream commit before
trying again. This can be done with:

    (cd upstream && git reset --hard <last_known_good_commit>)

EOF
  exit 1
}

init() {
  # Parse additional flags
  while getopts "f" flag; do
    case "${flag}" in
       f) force="true";;
       *) echo "Unexpected option ${flag}"; exit 1;;
    esac
  done

  assert_upstream_exists

  if [[ "${force}" != "true" ]]; then
    assert_upstream_tracked
  else
    echo "Warning: forcing init command to run even if the upstream submodule is modified."
  fi

  git submodule update --force --init
  # Iterating over the patches folder in sorted order,
  # apply the patch using a 3-way merge strategy. This mirrors the default behavior of 'git merge'
  cd upstream
  for patch in ../patches/*.patch; do
    if ! git apply --3way "${patch}" --allow-empty; then
      err_failed_to_apply "$(basename "${patch}")"
    fi
  done
}

checkout() {
  # Parse additional flags
  while getopts "f" flag; do
    case "${flag}" in
       f) force="true";;
       *) echo "Unexpected option ${flag}"; exit 1;;
    esac
  done

  assert_upstream_exists

  if [[ "${force}" != "true" ]]; then
    assert_upstream_tracked
  else
    echo "Warning: forcing checkout command to run even if the upstream submodule is modified."
  fi

  git submodule update --force --init
  cd upstream
  if [[ "${force}" == "true" ]]; then
    echo "Cleaning up any previous branches"
    git branch -D pulumi/patch-checkout
    git branch -D pulumi/checkout-base
  fi
  # Clean up any previous in-progress rebases.
  rebase_merge_dir=$(git rev-parse --git-path rebase-merge)
  rebase_apply_dir=$(git rev-parse --git-path rebase-apply)
  rm -rf "${rebase_merge_dir}"
  rm -rf "${rebase_apply_dir}"
  git fetch --all

  # Set the 'pulumi/checkout-base' branch to the current commit of the upstream repository
  # This is used to track the base commit of the patches
  # If rebasing, then this must be moved to the new base commit.
  git branch -f pulumi/checkout-base
  # Create a new branch 'pulumi/patch-checkout' which will contain the commits for each patch
  git checkout -B pulumi/patch-checkout

  for patch in ../patches/*.patch; do
    if ! git am --3way "${patch}"; then
      err_failed_to_apply "$(basename "${patch}")"
    fi
  done

    cat <<EOF

The patches have been checked out as commits in the './upstream' repository
on the 'pulumi/patch-checkout' branch. You can now edit the commits directly in the
upstream repository.

You can use the 'rebase' command to rebase the patches on top of a new base commit.

Once you have finished editing the commits, run the 'format_patches' command
to turn the commits back into patches in the 'patches' directory.

Note: The 'pulumi/checkout-base' branch is used to track the base commit of the patches.

EOF
}

rebase() {
  # Parse additional flags
  onto="pulumi/checkout-base"
  interactive="false"
  while getopts "io:" flag; do
    case "${flag}" in
       i) interactive="true";;
       o) onto="${OPTARG}";;
       *) echo "Unexpected option ${flag}"; exit 1;;
    esac
  done

  cd upstream
  assert_is_checked_out

  # Fetch the latest changes from the upstream repository
  git fetch --all
  # Set the "pulumi/checkout-base" branch to the new base commit ready for formatting the patches after
  git branch -f pulumi/checkout-base "${onto}"
  # Rebase the 'pulumi/patch-checkout' branch on top of the new base commit
  interactive_flag=""
  if [[ "${interactive}" == "true" ]]; then
    interactive_flag="--interactive"
  fi
  if ! git rebase --onto "${onto}" ${interactive_flag}; then
    echo "Rebase failed. Please resolve the conflicts and run 'git rebase --continue' in the upstream directory."
    exit 1
  fi
  cd ..
}

format_patches() {
  # Use git to resolve the possible location of files indicating a rebase might be in progress.
  rebase_merge_dir=$(cd upstream && git rev-parse --git-path rebase-merge)
  rebase_apply_dir=$(cd upstream && git rev-parse --git-path rebase-apply)

  if [[ -d "${rebase_merge_dir}" ]] || [[ -d "${rebase_apply_dir}" ]]; then
    echo "rebase still in progress in './upstream'. Please resolve the rebase in"
    exit 1
  fi

  # Remove all existing patches before creating the new ones in case they've been renamed or removed.
  rm patches/*.patch
  cd upstream
  # Extract patches from the commits in the 'pulumi/patch-checkout' branch into the 'patches' directory.
  # Use the 'pulumi/checkout-base' branch to determine the base commit of the patches.
  git format-patch pulumi/checkout-base -o ../patches --zero-commit --no-signature --no-stat --no-numbered
  # Checkout the 'pulumi/checkout-base' branch to the current commit of the upstream repository 
  # so the upstream HEAD is pointing at the correct base, ready to be committed as a submodule.
  git checkout pulumi/checkout-base
  cd ..
}

# Parse the first argument as the command name to run.
# Then, shift the arguments to pass the remaining arguments to the command.
case $1 in
  init)
    shift
    init "$@"
    ;;
  checkout)
    shift
    checkout "$@"
    ;;
  rebase)
    shift
    rebase "$@"
    ;;
  format_patches)
    shift
    format_patches "$@"
    ;;
  # Print usage if no arguments are provided or the command is unknown.
  "help"|"-h"|"--help")
    usage
    echo
    docs
    ;;
  "")
    echo "Error: command is required."
    echo
    usage
    exit 1
    ;;
  *)
    echo "Error: unknown command \"$1\"."
    echo
    usage
    exit 1
    ;;
esac
