[video](https://www.youtube.com/watch?v=2OHrTQVlRMg)

Exa: Better directory lists with colors.
```bash
sudo apt install exa

#.zshrc
alias ls="exa"
alias ll="exa -alh"
alias tree="exa --tree"
```
Bat: Replacement for cat with colors.
```bash
sudo apt install bat

#example
bat -p <filename>

#.zshrc
alias cat="bat"
```

RipGrep: Searching filesystem for test.

```bash
sudo apt install ripgrep

#examples 
rg <string> #search for string in desired path (case-sensitive)

rg -i <string> #search for string in desired path (case-insensitive)

rg -e '<regex>' #search using regex
```
