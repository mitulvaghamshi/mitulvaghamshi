# Git RESET

## Git create mode 100644

- [100]: Means it is an ascii text file.
- The first 3 digits describe the type of file.
- [644]: File permissions (`rw-r--r--`).
- The next 3 digits describe the file permissions.

## Git rm vs reset

```shell
git rm --cached file.txt
```

- The file will be removed completely from the staging area.

```shell
git reset file.txt
```

- The file won't be removed from the staging area, but reset to the previous
  state (one step back).

```shell
git checkout -- file.txt
```

- To ignore changes in working directory.

```shell
git reset file.txt
```

- To ignore changes in the staging area.

## Git RESET

```shell
git reset <reset-mode> <commit-id>
```

- Moves the HEAD to the specific commit, and all remaining recent commits will
  be removed.
- Mode will decide whether these changes are going to remove from the staging
  area and working directory or not.
- Thee allowed values for the mode are:

```shell
--mixed
--soft
--hard
--keep
--merge
```

## RESET with `--mixed`

- It is the default mode and won't touch the working directory.
- To discard commits in the local repository and to discard changes in staging
  areas we should use reset with `--mixed` option.

```shell
$ git log --oneline
6fcc300 (HEAD -> master) file3.txt added
86d0ca3 file2 added
9165d34 file1 added
```

- To discard last commit (all 3 options has the same meaning):

```shell
git reset --mixed 86d0ca3
git reset --mixed HEAD~1
git reset HEAD~1
```

- Now `HEAD` pointing to `86d0ca3`
- After undoing last commit:
  - The changes will be there in the working directory.

### Option 1:

- To discard changes in working directory also:

```shell
git checkout -- filename
```

- But make sure this file should not be a new file and should be already tracked
  by git.

### Option 2:

- If we want those changes to the local repository.

```shell
git add file3.txt
git commit -m 'file3 added again'
```

- To discard first two commits (all 3 options has same meaning):

```shell
git reset --mixed 9165d34
git reset --mixed HEAD~2
git reset HEAD~2

$ git log --oneline
9165d34 (HEAD -> master) file1 added
```

- It is not possible to remove random commits.
- `--mixed` will work only on the repository and staging area but not on the
  working directory.
- Whenever we are using `--mixed`, we can revert the changes, because changes
  are available in the working directory.

## RESET with --soft

- It is exactly the same as `--mixed` option, but changes are available in the
  working directory as well as in the staging area.
- It won't touch the staging area and working directory.
- As changes already present in the staging area, we just have to use commit to
  revert back.

```shell
$ git log --oneline
1979e61 (HEAD -> master) file3 added again
4d32eb3 file2 added again
9165d34 file1 added
```

- To discard the latest commit:

```shell
git reset --soft 4d32eb3 git reset --soft HEAD~1
```

- Now `HEAD` is pointing to `4d32eb3`
- The commits will be discarded only in the local repository, but changes will
  be there in the working directory and staging area.
- To Revert Changes we have to do just:

```shell
git commit -m "added"
RESET with --hard
```

- It is exactly the same as `--mixed` except that changes will be removed from
  everywhere (local repository, staging area, working directory).
- It is a more dangerous command and it is a destructive command.
- It is impossible to revert back and hence while using hard reset we have to
  take special care.

```shell
$ git log --oneline
3d7d370 (HEAD -> master) file3 added again
4d32eb3 file2 added again
9165d34 file1 added
```

- To remove recent two commits permanently:

```shell
git reset --hard 9165d34
git reset --hard HEAD~2
```

- Now changes will be removed from everywhere.

## RESET mode Summary

`--mixed`:

- Changes will be discarded in the local repo and staging area.
- It won't touch the working directory.
- Working tree won't be clean.
- But we can revert with:

```shell
git add ...
git commit
```

`--soft`:

- Changes will be discarded only in the local repository.
- It won't touch the staging area and working directory.
- Working tree won't be clean.
- But we can revert with:

```shell
git commit
```

`--hard`:

- Changes will be discarded everywhere.
- Working tree won't be clean. No way to revert.

## Notes

- If the commits are confirmed to the local repository and to discard those
  commits we can use reset command.
- But if the commits are confirmed to a remote repository then it is not
  recommended to use reset command and we have to use revert command.
