---
layout: post
title: Ruby Installation
---
Ruby can be confusing to install. Make sure to plan out if per-user environments are going to be used, or system-wide (Ruby, Gems, etc installed by root).

## Installing
Instead of using rvm or rbenv, stick to installing Ruby system-wide with pacman.

```
pacman -S ruby
```

## Paths
Caution editing your .bashrc or .zshrc.. root does not need to have a GEM_HOME or ~/.gem/ruby/2.0.0 added to its PATH

### ~/.gemrc
For root, create .gemrc so that when gems are installed as root, it uses the system-wide directory.

```
gem: --no-user-install
```

Optionally, create user's .gemrc as well, although it'd be the same as in /etc/gemrc, which is automatically made by the ArchPkg

```
gem: --user-install
```

## Updating Gems

Update system:  sudo gem update --system
Update user:  gem update

## Useful Links and References

[Archwiki: Ruby](https://wiki.archlinux.org/index.php/Ruby)

[Note from ArchDev about .gemrc](https://projects.archlinux.org/svntogit/packages.git/tree/trunk/ruby.install?h=packages/ruby)

