# My dotfiles

This directory contains the dotfiles for my system

## Requirements

Ensure you have the following installed on your system

### Git

```
sudo dnf install git-all
```

### GNU Stow

```
sudo dnf install stow
```

## Installation

First, check out the dotfiles repo in your `$HOME` directory using git

```
$ git clone git@github.com:abhamra/dotfiles.git
$ cd dotfiles
```

then use GNU stow to create symlinks

```
$ stow -t ~ common
$ stow -t ~ laptop
```

If on the home server, use the `/` directory instead of `$HOME` aka `~`.
```
$ stow -t / homeserver
```

The idea for using stow was from the Youtube channel "Dreams of Autonomy"; their video is [here](https://www.youtube.com/watch?v=y6XCebnB9gs).

Make sure to add command line stuff like fzf and bat, etc., from the video [here](https://www.youtube.com/watch?v=mmqDYw9C30I&ab_channel=JoseanMartinez).
**NOTE**: Don't forget to also install `lua5.1, liblua5.1-dev`, and `luarocks` to enable `lean.nvim`.
