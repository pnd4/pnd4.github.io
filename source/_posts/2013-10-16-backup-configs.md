---
layout: post
title: Backing up Configuration
---
## To-do
Pseudocode/Outline
Write Code
Keep adding to list of files.

## Brainstorm / Plans
Purpose: Simplify backing up configs.
Ideas
- Parse a list of files (backup_files.lst?)
- Copy files to a directory (~/backup_<date> ?)
- Archive the files?
- Encrypt?

## Files to backup
```
~/.zshrc
~/.zsh/
~/.Xresources
~/.xinitrc
~/.vimrc
~/.vim_runtime
~/.tmux.conf
~/.ssh/
~/.gnupg
~/.conkyrc
~/.config
~/.dzen
~/.bashrc
```

## Script code
```
#!/bin/bash
echo "Backing up config.."
echo "Processing $currentFile"
if [$? -eq 1]; then
    # move to next file
else
    # prompt user to continue
fi
echo "Done"
```

[^1] Reference one. <http://wiki.archlinux.org>

