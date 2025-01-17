include <../../libraries/std.scad>
include <connector.scad>
include <constants.scad>

front_sign_back_depth = dimension_scale(1.5);
front_sign_front_depth = dimension_scale(3);
front_sign_thickness = dimension_scale(0.25);
logo_thickness = 1;
front_sign_width = outer_half_width + front_sign_overhang;

module front_sign_text()
{
    logo_scale = front_sign_height / 84;
    up(inner_height - pole_size / 2 + front_sign_height / 2) fwd(outer_depth + pole_size / 2 + front_sign_thickness)
    {
        xrot(90) color("firebrick") linear_extrude(logo_thickness) xscale(logo_scale) yscale(logo_scale)
            import("rapidride_logo.svg", center = true);
    }
}

module front_sign(is_male)
{
    module front_sign_main()
    {
        up(inner_height - pole_size / 2) fwd(outer_depth + pole_size / 2)
        {
            up(front_sign_height) fwd(front_sign_thickness / 2 - front_sign_back_depth)
            {
                size1 = [ front_sign_width, front_sign_back_depth + front_sign_front_depth, front_sign_thickness ];
                cuboid(size1, anchor = LEFT + BOTTOM + BACK);
            }

            size2 = [ front_sign_width, front_sign_thickness, front_sign_height ];
            cuboid(size2, anchor = LEFT + BOTTOM + BACK);
        }

        up(inner_height)
        {
            right(outer_half_width / 2 - pole_size) front_sign_hook(false);
            right(outer_half_width / 2 + pole_size) front_sign_hook(false);
            right(outer_half_width - pole_size * 3) front_sign_hook(false);
        }
    }

    difference()
    {
        front_sign_main();
        size = [ outer_half_width * 2, outer_depth * 2, front_sign_height * 2 ];
        up(inner_height) right(outer_half_width / 2 + (is_male ? -1 : 1) * get_slop() / 2)
            cuboid(size, anchor = (is_male ? LEFT : RIGHT) + BACK);
    }
}