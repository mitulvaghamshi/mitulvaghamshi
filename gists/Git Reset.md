# Git RESET

Git create mode `100644`. File type [`100`]: An ASCII text file. File permissions [`644`]: (`rw-r--r--`).

## Git `rm` vs `reset`

```sh
# The file will be removed completely from the staging area.
git rm --cached file.txt
```

```sh
# The file won't be removed from the staging area, but reset to the previous state (one step back).
git reset file.txt
```

```sh
# To ignore changes in working directory.
git checkout -- file.txt
```

```sh
# To ignore changes in the staging area.
git reset file.txt
```

## Git RESET

```sh
# Moves the `HEAD` to the specific commit, and all remaining recent commits will be removed.
git reset <reset-mode> <commit-id>
```

Mode will decide whether these changes are going to remove from the staging area and working directory or not:

- `--mixed`
- `--soft`
- `--hard`
- `--keep`
- `--merge`

## RESET with `--mixed`

```sh
# This is the default mode and won't touch the working directory.
# To discard commits in local repo and changes in staging areas.
$ git log --oneline
6fcc300 (HEAD -> master) file3.txt added
86d0ca3 file2 added
9165d34 file1 added
```

```sh
# To discard last commit (all 3 options has the same meaning).
git reset --mixed 86d0ca3 # OR
git reset --mixed HEAD~1 # OR
git reset HEAD~1
# Now HEAD pointing to 86d0ca3
# After undoing last commit changes will be there in working directory.
```

### Option 1

Make sure this file should not be a new file and should be already tracked by git.

```sh
# To discard changes in working directory.
git checkout -- filename
```

### Option 2

```sh
# If we want those changes to the local repository.
git add file3.txt
git commit -m 'file3 added again'
```

```sh
# To discard first two commits (all 3 options has same meaning).
git reset --mixed 9165d34
git reset --mixed HEAD~2
git reset HEAD~2

$ git log --oneline
9165d34 (HEAD -> master) file1 added
```

It is not possible to remove random commits. `--mixed` will work only on the repository and staging area but not on the working directory. Whenever using `--mixed`, we can revert the changes, because changes are available in the working directory.

## RESET with `--soft`

This is same as `--mixed`, but changes are available in both working directory and staging area.

```sh
# Changes already present in the staging area, use commit to revert back.
$ git log --oneline
1979e61 (HEAD -> master) file3 added again
4d32eb3 file2 added again
9165d34 file1 added
```

```sh
# To discard the latest commit.
git reset --soft 4d32eb3 git reset --soft HEAD~1
# Now HEAD is pointing to 4d32eb3
```

The commits will be discarded only in the local repository, but changes will be there in the working directory and staging area.

```sh
# To Revert Changes we have to do just.
git commit -m "added"
```

## RESET with `--hard`

This is same as `--mixed` except that changes will be removed from everywhere (local repo, staging area, working directory).

```sh
# It's impossible to revert back.
$ git log --oneline
3d7d370 (HEAD -> master) file3 added again
4d32eb3 file2 added again
9165d34 file1 added
```

```sh
# To remove recent two commits permanently.
git reset --hard 9165d34
git reset --hard HEAD~2
# Now changes will be removed from everywhere.
```

## Reset mode summary

`--mixed`:

- Changes will be discarded in the local repo and staging area.
- It won't touch the working directory.
- Working tree won't be clean.
- Revert with: `git add ... && git commit`.

`--soft`:

- Changes will be discarded only in the local repo.
- It won't touch the staging area and working directory.
- Working tree won't be clean.
- Revert with: `git commit`

`--hard`:

- Changes will be discarded everywhere.
- Working tree won't be clean.
- Revert with: N/A

## Note

- **Reset**: If the commits are confirmed to a local repo.
- **Revert**: If the commits are confirmed to a remote repo.
