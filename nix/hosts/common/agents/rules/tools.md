# Tools

## Scripting

Python is not installed in this environment.
Don't use Python (`python` or `python3`).
Use Babashka (`bb`, Clojure) for scripting or automation.

## Preferred tools

- Use `fd` instead of `find` for file discovery.
- Use `rg` instead of `grep` for text searches.
- Use `eza` instead of `ls` for listing files.
- Use `eza -T` instead of `tree` for showing directory structures.

## Code Analysis

`ast-grep` is installed in this environment.
For any code search that requires understanding of syntax or code structure, you should default to using `ast-grep --lang [language] -p '<pattern>'`.
Adjust the `--lang` flag as needed for the specific programming language.
Avoid using text-only search tools unless a plain-text search is explicitly requested.

See `ast-grep` skill for details.

## Missing tools

To use missing tools, use nix-community/comma that enables you to use any tools in nixpkgs.

```bash
# to use cowsay command
, cowsay neato
```
