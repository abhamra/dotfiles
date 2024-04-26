# My dotfiles

This directory contains the dotfiles for my system

## Requirements

Ensure you have the following installed on your system

### Git

```
sudo apt-get install git-all
```

### GNU Stow

```
sudo apt-get install stow
```

## Installation

First, check out the dotfiles repo in your `$HOME` directory using git

```
$ git clone git@github.com:abhamra/dotfiles.git
$ cd dotfiles
```

then use GNU stow to create symlinks

```
$ stow .
```

The idea for using stow was from the Youtube channel "Dreams of Autonomy"; their video is [here](https://www.youtube.com/watch?v=y6XCebnB9gs).
