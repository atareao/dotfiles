# convert.yazi

## Requirements

- [yazi](https://github.com/sxyazi/yazi)
- [magick](https://archlinux.org/packages/extra/x86_64/imagemagick/)

## Installation

### Linux

```sh
git clone https://github.com/atareao/convert.yazi ~/.config/yazi/plugins/convert.yazi
```

or

```sh
ya pkg add atareao/convert
```

## Usage

Add this to your ~/.config/yazi/keymap.toml

```toml

[[mgr.prepend_keymap]]
on = ["c", "p"]
run = "plugin convert -- --extension='png'"
desc = "Convert selected files to PNG"

[[mgr.prepend_keymap]]
on = ["c", "j"]
run = "plugin convert -- --extension='jpg'"
desc = "Convert selected files to JPG"

[[mgr.prepend_keymap]]
on = ["c", "w"]
run = "plugin convert -- --extension='webp'"
desc = "Convert selected files to WebP"

```
