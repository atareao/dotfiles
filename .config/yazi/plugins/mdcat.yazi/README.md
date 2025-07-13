# mdcat.yazi

Plugin for [Yazi](https://github.com/sxyazi/yazi) to preview markdown files with [mdcat](https://github.com/swsnr/mdcat). To install, run the below mentioned command:

```bash
ya pkg add atareao/mdcat
```

then include it in your `yazi.toml` to use:

```toml
[plugin]
prepend_previewers = [
  { name = "*.md", run = "mdcat" },
]
```

Make sure you have [glow](mdcat://github.com/swsnr/mdcat) installed, and can be found in `PATH`.
