#!/bin/bash

# Nautilus-specific dark styling so folders and files stay visible, with a
# distinct accent-tinted look that stands out from the plain dark GTK theme.

# omarchy-hook runs .d hooks twice: once from the main hook (with colors) and
# once without. Skip the second pass so we never append an empty block.
if [[ -z "$primary_background" ]]; then
    exit 0
fi

gtk3_file="$HOME/.config/gtk-3.0/gtk.css"
gtk4_file="$HOME/.config/gtk-4.0/gtk.css"

# Flatpak Nautilus is sandboxed and reads its CSS from its own config dir
# instead of ~/.config/gtk-4.0/.
flatpak_nautilus_dir="$HOME/.var/app/org.gnome.Nautilus/config"

nautilus_css() {
cat << 'EOF'

/* ===== Nautilus overrides ===== */
.nautilus-window {
    background-color: @view_bg_color;
    color: @view_fg_color;
}

/* File list: dark background, light text */
.nautilus-window listview,
.nautilus-window treeview {
    background-color: @view_bg_color;
    color: @view_fg_color;
}

/* Sidebar: accent-tinted so it stands out from the file list */
.nautilus-window .sidebar {
    background-color: alpha(@accent_bg_color, 0.12);
}
.nautilus-window .sidebar .view {
    background-color: transparent;
    color: @view_fg_color;
}

/* Hover rows: accent-tinted */
.nautilus-window listview > row:hover,
.nautilus-window treeview:hover,
.nautilus-window .sidebar row:hover {
    background-color: alpha(@accent_bg_color, 0.30);
}

/* Selection: accent blue with light text, clearly visible */
.nautilus-window listview > row:selected,
.nautilus-window treeview:selected,
.nautilus-window .sidebar row:selected {
    background-color: @accent_bg_color;
    color: @accent_fg_color;
}
.nautilus-window listview > row:selected:backdrop,
.nautilus-window treeview:selected:backdrop,
.nautilus-window .sidebar row:selected:backdrop {
    background-color: alpha(@accent_bg_color, 0.55);
    color: @accent_fg_color;
}

/* Path bar */
.nautilus-window .path-bar button {
    background-color: alpha(@accent_bg_color, 0.15);
    color: @view_fg_color;
}
.nautilus-window .path-bar button:hover {
    background-color: alpha(@accent_bg_color, 0.35);
}
.nautilus-window .path-bar button:checked {
    background-color: @accent_bg_color;
    color: @accent_fg_color;
}

/* Floating bar (item count / progress) */
.nautilus-window .floating-bar {
    background-color: alpha(@accent_bg_color, 0.90);
    color: @accent_fg_color;
    border-radius: 8px;
}
EOF
}

nautilus_css >> "$gtk3_file"
nautilus_css >> "$gtk4_file"

if flatpak list --app 2>/dev/null | grep -q "org.gnome.Nautilus"; then
    mkdir -p "$flatpak_nautilus_dir/gtk-3.0" "$flatpak_nautilus_dir/gtk-4.0"
    nautilus_css >> "$flatpak_nautilus_dir/gtk-3.0/gtk.css"
    nautilus_css >> "$flatpak_nautilus_dir/gtk-4.0/gtk.css"
    success "Flatpak Nautilus detected, CSS applied to its config dir"
fi

require_restart "nautilus"
success "Nautilus theme updated!"
exit 0