dotfiles
--

### install

```shell
make init;and make deploy
```

```shell
sudo sh -c "which fish >> /etc/shells"
chsh -s $(which fish)
```

### update

```shell
make clean;and git pull;and make deploy
```

