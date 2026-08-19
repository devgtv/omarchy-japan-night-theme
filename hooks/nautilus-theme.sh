#!/bin/bash

# Nautilus-specific dark styling so folders and files stay visible.

# omarchy-hook runs .d hooks twice: once from the main hook (with colors) and
# once without. Skip the second pass so we never append an empty block.
if [[ -z "$primary_background" ]]; then
    exit 0
fi

gtk3_file="$HOME/.config/gtk-3.0/gtk.css"
gtk4_file="$HOME/.config/gtk-4.0/gtk.css"

nautilus_css() {
cat << 'EOF'

/* ===== Nautilus overrides ===== */
.nautilus-window,
.nautilus-window .view,
.nautilus-window listview,
.nautilus-window treeview,
.nautilus-window .sidebar,
.nautilus-window .sidebar .view,
.nautilus-window .places-treeview,
.nautilus-window .floating-bar {
    background-color: @view_bg_color;
    color: @view_fg_color;
}

.nautilus-window .view:selected,
.nautilus-window listview > row:selected,
.nautilus-window treeview:selected,
.nautilus-window .sidebar row:selected {
    background-color: @theme_selected_bg_color;
    color: @theme_selected_fg_color;
}

.nautilus-window .view:selected:backdrop,
.nautilus-window listview > row:selected:backdrop {
    background-color: @theme_unfocused_selected_bg_color;
    color: @theme_unfocused_selected_fg_color;
}

.nautilus-window .sidebar row:hover {
    background-color: alpha(@theme_selected_bg_color, 0.35);
}

.nautilus-window listview > row:hover {
    background-color: alpha(@theme_selected_bg_color, 0.25);
}

.nautilus-window .path-bar button,
.nautilus-window .search-bar {
    background-color: @view_bg_color;
    color: @view_fg_color;
}

.nautilus-window .breadcrumb-button {
    color: @view_fg_color;
}
EOF
}

nautilus_css >> "$gtk3_file"
nautilus_css >> "$gtk4_file"

require_restart "nautilus"
success "Nautilus theme updated!"
exit 0