include <../../libraries/std.scad>
include <constants.scad>

legs_pole_size = dimension_scale(3.5);
legs_flat_size = dimension_scale(12);
legs_flat_thickness = dimension_scale(1);
ground_thickness = 2;

module ground()
{
    size = [ inner_half_width + legs_flat_size, outer_depth + legs_flat_size, ground_thickness ];
    color_this("gray") back(legs_flat_size) cuboid(size, anchor = LEFT + BACK + TOP);
    right(inner_half_width)
    {
        cuboid([ legs_flat_size, legs_flat_size, legs_flat_thickness ], anchor = BOTTOM);
        prismoid(legs_pole_size, legs_pole_size, rounding = pole_rounding, h = legs_height);
        fwd(inner_depth) prismoid(legs_pole_size, legs_pole_size, rounding = pole_rounding, h = legs_height);
    }
}