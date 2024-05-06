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

Make sure to add command line stuff like fzf and bat, etc., from the video [here](https://www.youtube.com/watch?v=mmqDYw9C30I&ab_channel=JoseanMartinez).

Also, note that Oh My Posh is also quite nice, and I really like how it works with the rest of the set-up!
For future reference, try to use zsh on any new machines instead of bash; it maintains a lot of features but p10k and a lot of other native features
make it a more attractive pick across the board.
