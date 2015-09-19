tmux-gzp
========

**Tmux** **Github** **Zsh** **Peco**

# Description

This tpm plugin lists your repository or starred repository, then browse it with peco style.

# Requirements

* [tmux](https://tmux.github.io/)
* [zsh](http://www.zsh.org/)
* [peco](https://github.com/peco/peco)
* [tpm](https://github.com/tmux-plugins/tpm)
* [jq](https://github.com/stedolan/jq)

# Install

Install tpm and add the following line to your `~/.tmux.conf`.

```bash
set-option -g @plugin 'knakayama/tmux-gzp'
```

then, press `Prefix + I` in tmux session.

# Usage

Default key binding searching your repository is `Prefix + g`. If you want to change this key binding, set the following line to your `~/.tmux.conf`.

```bash
set-option -g @gzp-yrepo-key 'x' # or your favorite key binding
```

Default key binding searching your starred repository is `Prefix + G`. If you want to change this key binding, set the following line to your `~/.tmux.conf`.

```bash
set-option -g @gzp-srepo-key 'X' # or your favorite key binding
```

# License

MIT

# Author

[knakayama](https://github.com/knakayama)
