#!/bin/bash

# Nautilus-specific dark styling so folders and files stay visible, with a
# distinct accent-tinted look that stands out from the plain dark GTK theme.
#
# The CSS only references symbolic colors (@view_bg_color, @accent_bg_color,
# ...) defined in the same gtk.css file by the 10-gtk.sh hook, so it does not
# depend on color values being passed as environment variables.

gtk3_file="$HOME/.config/gtk-3.0/gtk.css"
gtk4_file="$HOME/.config/gtk-4.0/gtk.css"

# Flatpak Nautilus is sandboxed and reads its CSS from its own config dir
# instead of ~/.config/gtk-4.0/.
flatpak_nautilus_dir="$HOME/.var/app/org.gnome.Nautilus/config"

nautilus_css() {
cat << 'EOF'
/* ===== Nautilus overrides:begin ===== */
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
/* ===== Nautilus overrides:end ===== */
EOF
}

# Remove any previous block (marker-delimited), then append a fresh copy.
# This keeps the stylesheet clean no matter how many times the hook runs.
apply_css() {
    local gtk_file="$1"
    mkdir -p "$(dirname "$gtk_file")"
    if [[ -f "$gtk_file" ]]; then
        sed -i '/^\/\* ===== Nautilus overrides:begin ===== \*\/$/,/^\/\* ===== Nautilus overrides:end ===== \*\/$/d' "$gtk_file"
    fi
    nautilus_css >> "$gtk_file"
}

apply_css "$gtk3_file"
apply_css "$gtk4_file"

if flatpak list --app 2>/dev/null | grep -q "org.gnome.Nautilus"; then
    apply_css "$flatpak_nautilus_dir/gtk-3.0/gtk.css"
    apply_css "$flatpak_nautilus_dir/gtk-4.0/gtk.css"
fi