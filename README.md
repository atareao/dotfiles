# dotfiles

Mis dotfiles personales, gestionados con [**yadm**](https://yadm.io/).

[![Stars](https://img.shields.io/github/stars/atareao/dotfiles?style=flat-square&logo=github)](https://github.com/atareao/dotfiles/stargazers)
[![License](https://img.shields.io/github/license/atareao/dotfiles?style=flat-square)](LICENSE)
[![Last commit](https://img.shields.io/github/last-commit/atareao/dotfiles?style=flat-square)](https://github.com/atareao/dotfiles/commits/main)

Una colección de configuraciones para mi día a día en Linux: shell, editores,
terminales, gestores de ventanas, gestores de ficheros y un largo etcétera.
Todo vive bajo `.config/` (más `.gitconfig.jinja` y algunos scripts en `.local/bin`).

## Qué incluye

### Shell y prompt

| Herramienta | Carpeta |
|---|---|
| fish | [`.config/fish`](.config/fish) |
| zsh | [`.config/zsh`](.config/zsh) |
| starship | [`.config/starship`](.config/starship) |
| atuin | [`.config/atuin`](.config/atuin) |
| sheldon | [`.config/sheldon`](.config/sheldon) |
| television | [`.config/television`](.config/television) |
| tealdeer | [`.config/tealdeer`](.config/tealdeer) |
| sk (fzf) | [`.config/sk`](.config/sk) |

### Editores

| Herramienta | Carpeta |
|---|---|
| Neovim | [`.config/nvim`](.config/nvim) |
| Helix | [`.config/helix`](.config/helix) |
| nevi | [`.config/nevi`](.config/nevi) |
| Zed | [`.config/zed`](.config/zed) |

### Terminales y multiplexores

| Herramienta | Carpeta |
|---|---|
| kitty | [`.config/kitty`](.config/kitty) |
| Ghostty | [`.config/ghostty`](.config/ghostty) |
| WezTerm | [`.config/wezterm`](.config/wezterm) |
| Zellij | [`.config/zellij`](.config/zellij) |

### Gestores de ventanas y escritorio

| Herramienta | Carpeta |
|---|---|
| Hyprland | [`.config/hypr`](.config/hypr) |
| i3 | [`.config/i3`](.config/i3) |
| bspwm | [`.config/bspwm`](.config/bspwm) |
| niri | [`.config/niri`](.config/niri) |
| Sway | [`.config/sway`](.config/sway) |
| LeftWM | [`.config/leftwm`](.config/leftwm) |
| AGS (widgets) | [`.config/ags`](.config/ags) · [`.config/ags.sway`](.config/ags.sway) |
| Waybar | [`.config/waybar`](.config/waybar) |
| swaync | [`.config/swaync`](.config/swaync) |
| swaylock | [`.config/swaylock`](.config/swaylock) |
| swayr | [`.config/swayr`](.config/swayr) |
| dunst | [`.config/dunst`](.config/dunst) |
| picom | [`.config/picom`](.config/picom) |
| rofi | [`.config/rofi`](.config/rofi) |
| anyrun | [`.config/anyrun`](.config/anyrun) |
| sxhkd | [`.config/sxhkd`](.config/sxhkd) |
| tint2 | [`.config/tint2`](.config/tint2) |
| DankMaterialShell | [`.config/DankMaterialShell`](.config/DankMaterialShell) |
| GNOME | [`.config/gnome`](.config/gnome) · [`.config/gnome-extensions-configuration`](.config/gnome-extensions-configuration) |

### Gestores de ficheros

| Herramienta | Carpeta |
|---|---|
| Yazi | [`.config/yazi`](.config/yazi) |
| xplr | [`.config/xplr`](.config/xplr) |
| ranger | [`.config/ranger`](.config/ranger) |
| vifm | [`.config/vifm`](.config/vifm) |
| broot | [`.config/broot`](.config/broot) |
| superfile | [`.config/superfile`](.config/superfile) |
| Midnight Commander | [`.config/mc`](.config/mc) |
| felix | [`.config/felix`](.config/felix) |

### Monitorización del sistema

| Herramienta | Carpeta |
|---|---|
| btop | [`.config/btop`](.config/btop) |
| bottom | [`.config/bottom`](.config/bottom) |
| htop | [`.config/htop`](.config/htop) |
| nvtop | [`.config/nvtop`](.config/nvtop) |
| zfxtop | [`.config/zfxtop`](.config/zfxtop) |
| cava | [`.config/cava`](.config/cava) |

### Git y contenedores

| Herramienta | Carpeta |
|---|---|
| lazygit | [`.config/lazygit`](.config/lazygit) |
| lazydocker | [`.config/lazydocker`](.config/lazydocker) |

### Copias de seguridad y secretos

| Herramienta | Carpeta |
|---|---|
| rclone | [`.config/rclone`](.config/rclone) |
| resticprofile | [`.config/resticprofile`](.config/resticprofile) |
| rustic | [`.config/rustic`](.config/rustic) |
| gopass | [`.config/gopass`](.config/gopass) |
| systemd (timers de backup) | [`.config/systemd`](.config/systemd) |
| yadm (bootstrap, hooks, encrypt) | [`.config/yadm`](.config/yadm) |

### Utilidades

| Herramienta | Carpeta |
|---|---|
| Espanso | [`.config/espanso`](.config/espanso) |
| himalaya | [`.config/himalaya`](.config/himalaya) |
| goose | [`.config/goose`](.config/goose) |
| ignors | [`.config/ignors`](.config/ignors) |
| pamac | [`.config/pamac`](.config/pamac) |
| stasis | [`.config/stasis`](.config/stasis) |
| arnndn-models | [`.config/arnndn-models`](.config/arnndn-models) |

## Cómo usarlo

### Instalación con yadm

```bash
yadm clone https://github.com/atareao/dotfiles.git
```

Si el repo ya está clonado y quieres aplicar los cambios:

```bash
yadm pull
yadm status
```

`yadm` ejecutará el [bootstrap](.config/yadm/bootstrap) si existe, y los hooks
de [`.config/yadm/hooks`](.config/yadm/hooks) en cada operación.

### Plantillas

Algunos ficheros son plantillas [Jinja](https://jinja.palletsprojects.com/)
(`*.jinja`) y se renderizan con `yadm alt`. Por ejemplo,
[`.gitconfig.jinja`](.gitconfig.jinja) usa `{{ env.GMAIL_USER }}` para el correo,
así que necesitas definir esa variable de entorno antes de aplicarlo:

```bash
export GMAIL_USER="tu-correo@ejemplo.com"
yadm alt
```

Otras plantillas del repo: `.config/fish/config.fish.jinja`,
`.config/himalaya/config.toml.jinja`, `.config/rclone/rclone.conf.jinja`,
`.config/resticprofile/profiles.yaml.jinja`, `.config/rustic/*.jinja` y
`.local/bin/backup.sh.jinja`.

### Ficheros cifrados

[`.config/yadm/encrypt`](.config/yadm/encrypt) lista claves SSH y otros secretos
que se guardan cifrados con GPG. Tras clonar, descífralos con:

```bash
yadm decrypt
```

### Aviso

Estas son **mis configuraciones personales**: están pensadas para mi equipo, mis
rutas y mis flujos de trabajo. Úsalas como referencia y adáptalas antes de
aplicarlas tal cual. Revisa siempre los scripts y las plantillas.

## Licencia

[MIT](LICENSE) © 2017 Lorenzo Carbonell
