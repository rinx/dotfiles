# Tools

## Important rules

- Don't use Python scripts. Use Babashka scripts instead.

## Preferred tools

Use these tools instead of standard tools.

| standard tool | preferred tool |
| ------------- | -------------- |
| `grep`        | `rg`           |
| `find`        | `fd`           |

## Code Analysis

Use `ast-grep`. This tool enables to find specific code structures, or perform complex code queries.

## Missing tools

To use missing tools, use nix-community/comma that enables you to use any tools in nixpkgs.

```bash
# to use cowsay command
, cowsay neato
```
