# git

## git configuration

You can replace `git config` with `git config --global` to set a
default preference for all repositories.

```bash
git config user.email "fix@konex.dev"
git config user.name "konex5"
git config core.editor "emacs -nw"
# or
git config --edit
# you may want to fix the identity of the commit
git commit --amend --reset-author
```

```bash
# signing messages '-s'
git config user.signingkey <gpgkey>
git config commit.gpgsign true
```

## git commands

```bash
git init
git branch -M master
git remote add origin git@github.com:konex5/my-project.git
git push -u origin master

# start a new branch on the root
git checkout --orphan <branch_name>

# default branch name
git config --global init.defaultBranch <branch_name>

# copy branch
git branch -c <branch_name>
```

## git forks

```bash
# clone a single branch
git clone --branch master --single-branch git@github.com:NixOS/nixpkgs.git

# fetch a single branch
git fetch <remote_name> <branch_name>
git checkout FETCH_HEAD

# add upstream
git remote add upstream <remote_name>
# fetch without modifying your files
git fetch upstream
# merge
git merge upstream/master
```
