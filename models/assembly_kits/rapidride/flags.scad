include <../../libraries/std.scad>
include <constants.scad>

flag_pole_width = dimension_scale(2);
flag_pole_height = dimension_scale(72);
flag_height = dimension_scale(48);
flag_depth = dimension_scale(10);
flag_rim = dimension_scale(1);
flag_width = pole_size - pole_rounding * 4;
logo_thickness = 2;

module flag_poles()
{
    right(inner_half_width) up(inner_height + flag_pole_height)
    {
        cuboid([ pole_size, pole_size, flag_pole_height ], rounding = pole_rounding, anchor = TOP);
        size1 = [ pole_size, flag_pole_width ];
        h = flag_depth + pole_rounding * 2 + flag_rim + pole_size / 2;
        prismoid(size1, size1, rounding = pole_rounding, h = h, anchor = BOTTOM + BACK, orient = FORWARD);

        fwd(pole_size / 2)
        {
            size2 = [ pole_size - pole_rounding * 2, flag_depth + pole_rounding + flag_rim, flag_rim ];
            size3 = [ pole_size - pole_rounding * 2, flag_rim, flag_height + flag_rim * 2 ];
            down(flag_pole_width) cuboid(size2, anchor = TOP + BACK);
            down(flag_pole_width) cuboid(size3, anchor = TOP + BACK);
            down(flag_pole_width + flag_height + flag_rim * 2) cuboid(size2, anchor = BOTTOM + BACK);
        }
    }
}

module flags()
{
    difference()
    {
        color_this("firebrick") xcopies(inner_half_width * 2, 2)
            up(inner_height + flag_pole_height - flag_pole_width - flag_rim) fwd(pole_size / 2 + flag_rim)
                cuboid([ flag_width, flag_depth, flag_height ], anchor = TOP + BACK);
        flag_logos(true);
    }
}

module flag_logos(hole = false)
{
    logo_scale = flag_depth / 146;
    xcopies(inner_half_width * 2, 2) up(inner_height + flag_pole_height - flag_pole_width - flag_rim - flag_height / 2)
        fwd(pole_size / 2 + flag_rim + flag_depth / 2) yscale(logo_scale) zscale(logo_scale) zrot_copies(n = 2)
            right(flag_width / 2 - logo_thickness) yrot(90) color("white")
                linear_extrude(logo_thickness + (hole ? 1 : 0)) import("rapidride_logo.svg", center = true);
}