# dotfiles

Todos mis archivos de configuración en un único sitio

## Instalación

Actualmente estoy utilizando `chezmoi` como mi gestor de `dotfiles`, con lo que es la herramienta que tienes que utilizar para implantar estos mismos archivos de configuración en tu propia máquina.

El primer paso es instalar `chezmoi` en tu equipo. Para ello, en el caso de Ubuntu y derivados lo puedes hacer fácilmente utilizando,

```bash
sudo apt install chezmoi
```

En el caso de Arch y derivados,

```bash
sudo pacman -S chezmoi
```

O si simplemente, quieres instalar el *binario*, cosa que yo no te recomiendo, lo puedes hacer con,

```bash
sh -c "$(curl -fsLS get.chezmoi.io)"
```

### ¿Ya tienes tus dotfiles en GitHub?

Si ya tienes tus *dotfiles* en *GitHub*, con `chezmoi`, entonces lo puedes hacer fácilmente en una única línea de comandos,

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```

O si quieres instalar mis archivos de configuración, lo que de nuevo no te recomiendo, lo puedes hacer de la siguiente forma,

```bash
chezmoi init https://github.com/atareao/dotfiles.git
```
