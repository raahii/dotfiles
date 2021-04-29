# .files

<p align="left">
  <a href="https://github.com/raahii/dotfiles/actions?query=workflow%3AUbuntu"><img src=https://github.com/raahii/dotfiles/workflows/Ubuntu/badge.svg alt="Build Status"></a>
  <a href="https://github.com/raahii/dotfiles/actions?query=workflow%3AMacOS"><img src=https://github.com/raahii/dotfiles/workflows/MacOS/badge.svg alt="Build Status"></a>
  <a href="https://fishshell.com/"><img src="https://img.shields.io/badge/built%20with-fish-blue.svg" alt="fish"></a>
  <a href="https://neovim.io/"><img src="https://img.shields.io/badge/built%20with-neovim-blue.svg" alt="neovim"></a>
  <a href="https://github.com/tmux/tmux"><img src="https://img.shields.io/badge/built%20with-tmux-blue.svg" alt="tmux"></a>
</p>

## Setup

```shell
git clone https://github.com/raahii/dotfiles.git ~/dotfiles
cd ~/dotfiles
make init && make deploy && fish
```

(for MacOS) Optional:

```shell
softwareupdate -i -a
```


## Test with Docker

```shell
cd ~/dotfiles
docker build -f docker/Dockerfile.ubuntu . -t dotfiles-ubuntu
docker run -it -v (pwd):/root/dotfiles dotfiles-ubuntu /bin/bash
```

## Acknowledgements

My dotfiles are based on these awesome repositories. :fire: Thank you very much.

- [alrra/dotfiles](https://github.com/alrra/dotfiles)
- [b4b4r07/dotfiles](https://github.com/b4b4r07/dotfiles)
- [shunk031/dotfiles](https://github.com/shunk031/dotfiles)
