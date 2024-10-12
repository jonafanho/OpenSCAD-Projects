include <../../libraries/std.scad>
include <constants.scad>

front_sign_back_depth = dimension_scale(1.5);
front_sign_front_depth = dimension_scale(3);
front_sign_thickness = dimension_scale(0.25);
logo_thickness = 2;
front_sign_width = outer_half_width + front_sign_overhang;

module front_sign_main()
{
    logo_scale = front_sign_height / 84;
    up(inner_height - pole_size / 2) fwd(outer_depth + pole_size / 2)
    {
        size = [ front_sign_width * 2, front_sign_thickness, front_sign_height ];
        cuboid(size, anchor = BOTTOM + BACK);
        up(front_sign_height / 2) fwd(front_sign_thickness) xscale(logo_scale) zscale(logo_scale) xrot(90)
            color("firebrick") linear_extrude(logo_thickness) import("rapidride_logo.svg", center = true);
    }
}

module front_sign_top()
{
    up(inner_height - pole_size / 2 + front_sign_height)
        fwd(outer_depth + pole_size / 2 + front_sign_thickness / 2 - front_sign_back_depth)
    {
        size = [ front_sign_width, front_sign_back_depth + front_sign_front_depth, front_sign_thickness ];
        cuboid(size, anchor = LEFT + BOTTOM + BACK);
    }
}