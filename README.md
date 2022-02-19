# dotfiles

## Get Started

```bash
git clone https://github.com/tqer39/dotfiles.git
cd ./dotfiles
bash ./setup.sh
```

## shell

### bash

```bash
#!/home/linuxbrew/.linuxbrew/bin/bash
chsh -s $(which bash)
```

### zsh

```bash
#!/usr/bin/zsh
echo $(which zsh) | sudo tee -a /etc/shells
chsh -s $(which zsh)
```

### fish

- see https://natsukium.github.io/fish-docs-jp/tutorial/switching_to_fish.html

```bash
#!/home/linuxbrew/.linuxbrew/bin/fish
echo (which fish) | sudo tee -a /etc/shells
chsh -s (which fish)
```
