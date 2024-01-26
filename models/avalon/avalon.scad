include <../libraries/rounding.scad>
include <../libraries/std.scad>
use <../fonts/Salsa-Regular.ttf>

module blue_shape()
{
    polygon(round_corners(path = star(n = 5, r = 10, ir = 5), r = 1));
}

module red_shape()
{
    zrot_copies(n = 5) left(6) polygon(round_corners(rect([ 4, 2 ]), r = 1));
}

module draw_text(text2, x, y, font_size, anchor = str("baseline", CENTER), thickness = 0, font = "Salsa-Regular")
{
    right(x) fwd(y) offset(thickness) text(text2, font_size, font, anchor = anchor);
}