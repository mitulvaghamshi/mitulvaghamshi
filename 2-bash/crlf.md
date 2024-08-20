## Convert: CRLF

Convert from legacy Mac-style CR line endings to UNIX-style LF line endings:

```sh
tr '\r' '\n' < mac_text_file > unix_text_file
```

Convert from UNIX-style LF to legacy Mac-style CR line endings:

```sh
tr '\n' '\r' < unix_text_file > mac_text_file
```

Convert from Windows-style CR/LF line endings (or LF/CR line endings) to UNIX
line endings:

```sh
tr -d '\r' < windows_text_file > unix_text_file
```

Convert from UNIX-style LF line endings to Windows-style CR/LF line endings:

```sh
CR="$(printf "\r")"
sed "s/$/$CR/" < unix_text_file > windows_text_file
```
