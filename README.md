# .files

<p align="left">
  <a href="https://github.com/raahii/dotfiles/actions?query=workflow%3AMacOS"><img src=https://github.com/raahii/dotfiles/workflows/MacOS/badge.svg alt="Build Status"></a>
</p>



## Setup

```shell
bash -c "$(curl -fsSL https://raw.githubusercontent.com/raahii/dotfiles/main/setup.sh)"
```

For macOS:

```shell
softwareupdate -i -a
```



## Update

Brewfile:

```sh
brew bundle dump --file ~/dotfiles/brew/Brewfile
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
