# Night Journeys — illustration masters

These are the three original, editable illustrations, stored as gzip-compressed
SVG. Each has a 16:9 viewBox; the upper eighth is kept clear for a desktop bar.
The downloadable wallpapers are rendered directly at 3840 × 2160, with a fine
paper grain added to the JPEGs.

For example, to export Kyoto Andon at a different resolution with librsvg:

```bash
gzip -dc kyoto-andon.svgz | rsvg-convert -w 5120 -h 2880 > kyoto-andon.png
```
