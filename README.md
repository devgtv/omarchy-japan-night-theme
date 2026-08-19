# Omarchy Japan Night Theme

A dark anime night theme for [Omarchy](https://omarchy.org/) — Japanese night
cityscapes with a deep ocean-blue palette extracted from the wallpapers.

![Street at night preview](backgrounds/japan-night-street-dim.jpg)
![Moonlit city preview](backgrounds/japan-night-moon-dim.jpg)
![Night scene 1](backgrounds/japan-night-1.jpg)
![Night scene 2](backgrounds/japan-night-2.jpg)
![Night scene 3](backgrounds/japan-night-3.jpg)
![Night scene 4](backgrounds/japan-night-4.jpg)

## Wallpapers

All wallpapers are dark night scenes, matching the theme's atmosphere.

- **japan-night-street-dim.jpg** — empty city street at night with stars over
  buildings and trees
- **japan-night-moon-dim.jpg** — anime city street at night with the moon
- **japan-night-1.jpg** to **japan-night-4.jpg** — additional night scenes
  (AI-generated)

## Installation

Requires an Omarchy installation. Install and apply the theme in one command:

```bash
omarchy theme install https://github.com/devgtv/omarchy-japan-night-theme.git
```

Or, from a terminal:

```bash
# Clone to ~/.config/omarchy/themes/japan-night and apply automatically
omarchy theme install git@github.com:devgtv/omarchy-japan-night-theme.git
```

The theme is applied automatically after install. To apply it manually later:

```bash
omarchy theme set japan-night
```

## What gets themed

Running `omarchy theme set japan-night` generates color configurations for:

- **Terminals** — Alacritty, Foot, Kitty, Ghostty
- **Neovim / LazyVim** — via the `aether.nvim` colorscheme with the Japan
  Night palette
- **btop, helix, vscode, obsidian, tmux**
- **Omarchy shell** — bar, widgets, notifications
- **GTK / Qt** apps (including Nautilus), Firefox, Zen, Discord, Spotify,
  Steam and more

## Nautilus (optional)

Nautilus follows the dark GTK theme automatically, but the repo ships a hook
that adds explicit Nautilus styling so folders and files stay clearly visible
on the dark background. Install it with:

```bash
omarchy hook install theme-set hooks/nautilus-theme.sh
```

Then re-apply the theme to generate the CSS and restart Nautilus:

```bash
omarchy theme set japan-night
```

The hook appends Nautilus overrides to `~/.config/gtk-3.0/gtk.css` and
`~/.config/gtk-4.0/gtk.css` on every theme change.

## Customization

Backgrounds for this theme (stock or custom) can be added to
`~/.config/omarchy/backgrounds/japan-night/` or the theme directory
`~/.config/omarchy/themes/japan-night/backgrounds/`, then cycle with:

```bash
omarchy theme bg next
```

## Credits

Wallpapers sourced from Pinterest — see the [original pin
1](https://br.pinterest.com/pin/1050464681823407082/) and [original pin
2](https://br.pinterest.com/pin/698198748471118783/). Moonlit city street art
credited to [IAMAG on Twitter](https://twitter.com/iamagco).

## Contributors

- **Michael91** — helper and reviewer: identified why the Nautilus hook did
  not run under the plain hook runner and contributed the marker-based,
  idempotent CSS approach.
- **im001** — thanks a lot for the feedback and support!

Thank you both for helping make this theme better!