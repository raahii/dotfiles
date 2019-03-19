## .files

### install

```shell
make init && make deploy
```

### use fish as default shell

```shell
sudo sh -c "which fish >> /etc/shells"
chsh -s $(which fish)
```

```shell
fisher
```

### update

```shell
make update
```
---

### try deploying

```shell
docker build -f ./test/Dockerfile.ubuntu  . -t dotfiles-ubuntu
```
