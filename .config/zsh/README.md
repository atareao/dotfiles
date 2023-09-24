# ZSH without Oh-My-Zsh

```
mkdir -p ~/.config/zsh/plugins
touch ~/.config/zsh/zshrc
if [[ -f ~/.zshrc ]]; then
    mv ~/.zshrc ~/.zsh.bak
fi
ln -s ~/.config/zsh/zshrc ~/.zshrc
if [[ -f ~/.zsh_history ]]; then
    mv .zsh_history ~/.config/zsh/zsh_history
else
    touch ~/.config/zsh/zsh_history
fi
# download plugins
cd ~/.config/zsh/plugins/
git clone git@github.com:zdharma-zmirror/fast-syntax-highlighting.git
git clone git@github.com:zsh-users/zsh-autosuggestions.git
git clone git@github.com:zsh-users/zsh-completions.git
```

Every new completion goes to ~/.config/zsh/plugins/custom-completions/

For example,

```bash
rustup completions zsh cargo > ~/.config/zsh/plugins/custom-completions/_cargo
```

In order to update the *plugins*, do,

```bash
cd ~/.config/zsh/plugins/
just update
```


