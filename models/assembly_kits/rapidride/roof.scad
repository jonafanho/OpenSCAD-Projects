include <../../libraries/std.scad>
include <constants.scad>

drain_width = dimension_scale(6.5);
roof_half_thickness = dimension_scale(0.25);
front_slope_height = dimension_scale(4);
back_slope_height = dimension_scale(2.25);
roof_slope = (front_slope_height - back_slope_height) / (outer_depth - drain_width);
slope_angle = atan2(front_slope_height - back_slope_height, outer_depth - drain_width);

function get_roof_height(position) = roof_slope * position + back_slope_height;

module top_poles()
{
    up(inner_height)
    {
        prismoid(pole_size, pole_size, rounding = pole_rounding, h = outer_half_width, orient = RIGHT);
        fwd(inner_depth) prismoid(pole_size, pole_size, rounding = pole_rounding, h = outer_half_width, orient = RIGHT);
        fwd(outer_depth) prismoid(pole_size, pole_size, rounding = pole_rounding, h = outer_half_width, orient = RIGHT);

        fwd(outer_depth / 2)
        {
            size = [ pole_size, outer_depth + pole_size, pole_size ];
            right(inner_half_width) cuboid(size, rounding = pole_rounding);
            right(outer_half_width) cuboid(size, rounding = pole_rounding);
        }

        up(pole_size / 2) right(outer_half_width) fwd(pole_size / 2)
        {
            side_width = pole_size / 2 - pole_rounding;
            color_this("firebrick") fwd(drain_width)
            {
                size1 = [ side_width, back_slope_height ];
                size2 = [ side_width, front_slope_height ];
                shift = [ 0, (front_slope_height - back_slope_height) / 2 ];
                h = outer_depth - drain_width;
                prismoid(size1 = size1, size2 = size2, shift = shift, h = h, anchor = LEFT + FRONT + BOTTOM,
                         orient = FRONT);
            }
            fwd(outer_depth) cuboid([ side_width * 2, pole_size, pole_size / 2 ], anchor = FRONT + TOP);
        }
    }
}

module drain()
{
    up(inner_height + pole_size / 2) fwd(pole_size / 2 + drain_width / 2) difference()
    {
        cuboid([ outer_half_width + front_sign_overhang, drain_width, back_slope_height ], anchor = LEFT + BOTTOM);
        size1 = [ back_slope_height / 2, drain_width - back_slope_height / 2 ];
        size2 = [ back_slope_height, drain_width - back_slope_height / 2 ];
        h = outer_half_width + front_sign_overhang + 1;
        up(back_slope_height) prismoid(size1 = size1, size2 = size2, h = h, anchor = BOTTOM, orient = RIGHT);
    }
}

module roof(profile_anchor)
{
    unit_height = (front_sign_height - pole_size - front_slope_height) / cos(slope_angle) - roof_half_thickness * 2;
    small_unit_width = unit_height * sqrt(2) / 2;
    unit_width = unit_height * 2 + small_unit_width * 4;
    path = [
        [ -small_unit_width, 0, unit_height ],
        [ small_unit_width, 0, unit_height ],
        [ small_unit_width + unit_height, 0, 0 ],
        [ small_unit_width * 3 + unit_height, 0, 0 ],
        [ small_unit_width * 3 + unit_height * 2, 0, unit_height ],
        [ unit_width + small_unit_width, 0, unit_height ],
    ];

    up(inner_height + pole_size / 2 + back_slope_height) fwd(pole_size / 2 + drain_width / 2) intersection()
    {
        size = [ outer_half_width, outer_depth - drain_width / 2, front_sign_height - back_slope_height - pole_size ];
        cuboid(size, anchor = LEFT + BOTTOM + BACK);
        xcopies(unit_width, l = outer_half_width, sp = [ 0, 0, 0 ])
        {
            profile = rect([ outer_depth * 3, roof_half_thickness / cos(PI / 8) ], anchor = profile_anchor);
            fwd(drain_width / 2) xrot(-slope_angle) up(roof_half_thickness) path_sweep(profile, path);
        }
    }
}

module roof_1()
{
    roof(BACK);
    middle_depth = (inner_depth + outer_depth) / 2;

    up(inner_height + pole_size / 2)
    {
        pole_length = outer_half_width - pole_size / 2 + pole_rounding;
        front_size = [ pole_length, pole_size - pole_rounding, front_slope_height ];
        fwd(outer_depth + pole_size / 2) cuboid(front_size, anchor = LEFT + BOTTOM + FORWARD);

        fwd(middle_depth)
        {
            prismoid(panel_pole_thickness, panel_pole_thickness, rounding = panel_pole_rounding, h = pole_length,
                     anchor = BOTTOM + RIGHT, orient = RIGHT);

            middle_position = middle_depth - drain_width - pole_size / 2 + panel_pole_thickness / 2;
            size = [ pole_length, panel_pole_thickness, get_roof_height(middle_position) - panel_pole_thickness / 2 ];
            up(panel_pole_thickness / 2) cuboid(size, anchor = LEFT + BOTTOM);
        }

        inner_position = inner_depth - drain_width - pole_rounding;
        size = [ pole_length, pole_size - pole_rounding * 2, get_roof_height(inner_position) ];
        fwd(inner_depth) cuboid(size, anchor = LEFT + BOTTOM);

        right(outer_half_width) fwd(pole_size / 2 + drain_width)
        {
            side_width = pole_size / 2 - pole_rounding;
            size1 = [ side_width, back_slope_height ];
            size2 = [ side_width, front_slope_height ];
            shift = [ 0, (front_slope_height - back_slope_height) / 2 ];
            h = outer_depth - drain_width;
            prismoid(size1 = size1, size2 = size2, shift = shift, h = h, anchor = RIGHT + FRONT + BOTTOM,
                     orient = FRONT);
        }
    }
}

module roof_2()
{
    color_this("gray")
    {
        roof(FORWARD);

        up(inner_height + back_slope_height + pole_size / 2) fwd(drain_width + pole_size / 2) right(outer_half_width)
        {
            height1 = front_sign_height - front_slope_height - pole_size;
            size1 = [ pole_size / 2, height1 ];
            s1 = [ 0, front_slope_height - back_slope_height ];
            h1 = outer_depth - drain_width;
            prismoid(size1 = size1, size2 = size1, shift = s1, h = h1, anchor = LEFT + BOTTOM + FRONT, orient = FRONT);

            height2 = get_roof_height(-drain_width / 2) - back_slope_height + height1;
            size2 = [ pole_size / 2, height2 ];
            h2 = drain_width / 2;
            s2 = [ 0, (height1 - height2) / 2 ];
            prismoid(size1 = size1, size2 = size2, shift = s2, h = h2, anchor = LEFT + BOTTOM + BACK, orient = BACK);
        }
    }
}