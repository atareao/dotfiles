import Widget from "resource:///com/github/Aylur/ags/widget.js";
import cairo from "cairo";
import Gdk from "gi://Gdk";
import GdkPixbuf from "gi://GdkPixbuf";

import options from "../options.js";

/** @param image  */
const Wallpaper = (filename) =>
  Widget.DrawingArea({
    class_name: "wallpaper",
    vexpand: true,
    hexpand: true,
    setup: (self) =>
      self.connect("draw", (self, cr) => {
        const screen = self.get_screen();
        const display = self.get_display();
        const root_window = screen.get_root_window();
        const monitor = display.get_monitor_at_window(root_window);
        const geometry = monitor.get_geometry();
        const width = geometry.width;
        const height = geometry.height;

        const surface = new cairo.ImageSurface(cairo.FORMAT_ARGB32, width, height);
        const pixbuf = GdkPixbuf.Pixbuf.new_from_file_at_scale(filename, width, height, false);
        const ctx = new cairo.Context(surface);
        ctx.save();
        Gdk.cairo_set_source_pixbuf(ctx, pixbuf, 0, 0);
        ctx.paint();
        ctx.restore();
        cr.setSourceSurface(surface, 0, 0);
        cr.paint();
        self.set_size_request(width, height);
      }),
  });

const filename = options.desktop.wallpaper.img.value;

/** @param {number} monitor  */
export default (monitor) =>
  Widget.Window({
    name: `wallpaper_${monitor}`,
    monitor,
    class_name: "wallpaper",
    layer: 'background',
    child: Widget.Box({
      children: [
        Widget.Label({
          label: "for some reason single chidren sometimes dont render",
          css: "color: transparent;",
        }),
        Wallpaper(filename),
        Widget.Label({
          label: "for some reason single chidren sometimes dont render",
          css: "color: transparent;",
        }),
      ],
    }),
  });

