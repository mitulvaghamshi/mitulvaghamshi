## Unix Find

```sh
find [<where>] <how> <what> [<and what>]
```

The find command performs a recursive search unless `-maxdepth` limits the directory levels it traverses.

Find `foo.txt` (case-sensitive)

```sh
find . -name foo.txt
```

Find `foo.txt` (case-insensitive)

```sh
find . -iname foo.txt
```

Locate `.tmp` files and *remove* them

```sh
find / "*.tmp" -delete
```

Locate files (excluding directories or links) ending with `.iso`

```sh
find / -iname "*.iso" -type f
```

Find all file types owned by *ricardo*

```sh
find / -user ricardo
```

Find files owned by *ricardo* ending in `.iso` that exceed `1G` and *remove* them

```sh
find / -user ricardo -iname "*.iso" -type f -size +1G -delete
```

Find all files owned by user id `1000`

```sh
find / -uid 1000
```

Find files owned by `olduser` and apply `chown` to transfer ownership to `newuser`

```sh
find / -user olduser -exec chown newuser {} \;
```

Find files below `/var/log` ending in `.log` and *compress* them

```sh
find /var/log -type f -name "*.log" -exec gzip {} \;
```

Find files last accessed over *30 days* ago

```sh
find / -type f -atime +30
```

Find files modified within the *last hour*

```sh
find / -type f -mmin -60
```

Find files with exact permissions `777`

```sh
find / -perm 777 -ls
```

Find files with `setgid` and `sticky` bits

```sh
find / -perm /g=s,o=t
```

---

## Unix find cmd & spaces

When using the find command with file paths containing spaces, several methods help ensure proper shell interpretation and command execution.

Using Double Quotes:

The most common approach is to wrap the full path, including spaces, in double quotes so it is treated as one argument.

```sh
find . -name "My File With Spaces.txt"
```

Escaping Spaces with Backslashes:

Alternatively, each space in a file path can be escaped with a backslash (`\`), which directs the shell to treat the space as part of the name rather than a separator.

```sh
find . -name My\ File\ With\ Spaces.txt
```

Using `-print0` with `xargs -0`:

When sending output from find to another command such as `xargs`, the `-print0` and `-0` options are reliable. They transmit filenames separated by null characters, handling spaces and special characters effectively.

```sh
find . -name "*.txt" -print0 | xargs -0 rm
```

Using `-exec` with find:

When running a command directly, `-exec` lets find pass the filename as one argument despite spaces. The `{}` placeholder stands for the file, and `\;` ends the command.

```sh
find . -name "*.txt" -exec ls -l "{}" \;
```

Escaping spaces with backslashes works, but double quotes or `-print0` with `xargs -0` are usually more dependable, especially with multiple spaces or special characters.

---

```sh
find web -type f \( -iname ".html" -o -iname ".js" -o -iname ".css" -o -iname ".json" \) -print | while read "file"; do TMP=$(mktemp "$file.XXXX"); cat "$file" | tr -d '\n\r' | tr -s '[:space:]' > "$TMP"; mv -f "$TMP" "$file"; done
```
