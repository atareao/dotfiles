# dotfiles

Todos mis archivos de configuración en un único sitio

## Instalación

Actualmente estoy utilizando `yadm` como mi gestor de `dotfiles`, con lo que es la herramienta que tienes que utilizar para implantar estos mismos archivos de configuración en tu propia máquina.

El primer paso es instalar `yadm` en tu equipo. Para ello, en el caso de Ubuntu y derivados lo puedes hacer fácilmente utilizando,

```bash
sudo apt install yadm
```

En el caso de Arch y derivados,

```bash
sudo pacman -S yadm
```

### Instalar los dotfiles

Recuerda que instalar los dotfiles puede *machacar* tus dotfiles, con lo que tienes que estar atento a esto. El primer paso es clonar el repositorio, para ello, simplemente tienes que ejecutar los siguientes comandos,

```bash
yadm clone https://github.com/atareao/dotfiles.git
yadm status
```

En el caso de que tengas un repositorio propio, en lugar de utilizar `https://github.com/atareao/dotfiles.git` tienes que utilizar `git@github.com:atareao/dotfiles.git`

Antes de continuar, tienes que tener en cuenta que algunos de los archivos que estoy utilizando son plantillas. Esto quiere decir, que en mi caso las plantillas las reemplazaré por los valores que tengo almacenados.

En mi caso, estoy utilizando `gopass` para guardar toda la información sensible. Con sensible, no me refiero únicamente a contraseñas, sino también a otra información, que simplemente no quiero que esté en mis dotfiles.

Para convertir estas plantillas en la configuración correspondiente, reemplazo los valores de esas plantillas por los valores que tengo almacenados en `gopass`, y para ello, utilizo un script que se encuentra en los dotfiles. Todo muy meta, como puedes ver. Básicamente se trata de `yadmalt`. Que es mi propia interpretación de `yadm alt`.

El archivo `yadmalt` se encuentra en el repositorio propio, lo que si que es necesario es disponer de los credenciales para restaurar todo el sistema.

