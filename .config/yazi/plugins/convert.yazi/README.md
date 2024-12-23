# convert.yazi

## Requirements

- [yazi](https://github.com/sxyazi/yazi)
- [magick](https://archlinux.org/packages/extra/x86_64/thunar/)

## Installation

### Linux 

```sh
git clone https://github.com/atareao/convert.yazi ~/.config/yazi/plugins/convert.yazi
```

or

```sh
ya pack -a atareao/convert
```

## Usage

Add this to your ~/.config/yazi/keymap.toml, inside of `[manager]`


```toml
prepend_keymap = [
    { on   = [ "c", "j" ], run  = "plugin convert --args='--extension=jpg'", desc = "Convert image to JPG" },
    { on   = [ "c", "p" ], run  = "plugin convert --args='--extension=png'", desc = "Convert image to PNG" },
    { on   = [ "c", "w" ], run  = "plugin convert --args='--extension=webp'", desc = "Convert image to WEBP" },
]
```
