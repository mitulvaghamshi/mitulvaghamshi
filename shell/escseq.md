## Attribute escape sequences

| Escape sequence | Description                                                |
| --------------- | ---------------------------------------------------------- |
|                 |                                                            |
| ^[[m or ^[[0m   | Resets all attributes to default.                          |
|                 |                                                            |
| ^[[1m           | Enables "bold" display. Mutually exclusive with (dim).     |
| ^[[2m           | Enables "dim" display. Mutually exclusive with (bold).     |
|                 |                                                            |
| ^[[3m           | Enables "standout" display.                                |
| ^[[4m           | Enables underlined display.                                |
|                 |                                                            |
| ^[[5m           | <blink>.                                                   |
| ^[[6m           | Fast blink or strike-through.                              |
| ^[[7m           | Enables reversed (inverse) display.                        |
|                 |                                                            |
| ^[[8m           | Enables hidden (background-on-background) display.         |
| ^[[9m           | Unused.                                                    |
|                 |                                                            |
| ^[[10m - ^[[19m | Font selection codes. Unsupported in most terminal.        |
| ^[[20m          | "Fraktur" typeface. Unsupported almost universally.        |
| ^[[21m          | Unused.                                                    |
|                 |                                                            |
| ^[[22m          | Disables "bright/bold" or "dim" display. Code 1m or 2m.    |
| ^[[23m          | Disables "standout" display.                               |
| ^[[24m          | Disables underlined display.                               |
| ^[[25m          | </blink>. Also disables slow blink or strike-through (6m). |
| ^[[26m          | Unused.                                                    |
| ^[[27m          | Disables reversed (inverse) display.                       |
| ^[[28m          | Disables hidden (background-on-background) display.        |
| ^[[29m          | Unused.                                                    |

## Color escape sequences

| Terminfo capability | Escape sequence | Description                   |
| :------------------ | :-------------- | :---------------------------- |
| **Foreground**      |                 |                               |
| setaf 0             | ^[[30m          | Sets fg color to black.       |
| setaf 1             | ^[[31m          | Sets fg color to red.         |
| setaf 2             | ^[[32m          | Sets fg color to green.       |
| setaf 3             | ^[[33m          | Sets fg color to yellow.      |
| setaf 4             | ^[[34m          | Sets fg color to blue.        |
| setaf 5             | ^[[35m          | Sets fg color to magenta.     |
| setaf 6             | ^[[36m          | Sets fg color to cyan.        |
| setaf 7             | ^[[37m          | Sets fg color to white.       |
|                     | ^[[38m          | Unused.                       |
| setaf 9             | ^[[39m          | Sets fg color to the default. |
| **Background**      |                 |                               |
| setab 0             | ^[[40m          | Sets bg color to black.       |
| setab 1             | ^[[41m          | Sets bg color to red.         |
| setab 2             | ^[[42m          | Sets bg color to green.       |
| setab 3             | ^[[43m          | Sets bg color to yellow.      |
| setab 4             | ^[[44m          | Sets bg color to blue.        |
| setab 5             | ^[[45m          | Sets bg color to magenta.     |
| setab 6             | ^[[46m          | Sets bg color to cyan.        |
| setab 7             | ^[[47m          | Sets bg color to white.       |
|                     | ^[[48m          | Unused.                       |
| setab 9             | ^[[49m          | Sets bg color to the default. |
