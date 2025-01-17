include <../../libraries/std.scad>
include <connector.scad>
include <constants.scad>

pole_break = inner_half_width - pole_size * 2;
drain_width = dimension_scale(6.5);
roof_half_thickness = dimension_scale(0.36);
front_slope_height = dimension_scale(4);
back_slope_height = dimension_scale(2.25);
roof_slope = (front_slope_height - back_slope_height) / (outer_depth - drain_width);
slope_angle = atan2(front_slope_height - back_slope_height, outer_depth - drain_width);

function get_roof_height(position) = roof_slope * position + back_slope_height;

module top_poles_1()
{
    up(inner_height) difference()
    {
        union()
        {
            right(outer_half_width)
            {
                h = outer_half_width - pole_break;
                prismoid(pole_size, pole_size, rounding = pole_rounding, h = h, orient = LEFT);
                fwd(inner_depth) prismoid(pole_size, pole_size, rounding = pole_rounding, h = h, orient = LEFT);
                fwd(outer_depth) prismoid(pole_size, pole_size, rounding = pole_rounding, h = h, orient = LEFT);
            }

            right(inner_half_width)
            {
                prismoid(pole_size, pole_size, h = pole_size, rounding = pole_rounding, anchor = CENTER);
                fwd(inner_depth)
                    prismoid(pole_size, pole_size, h = pole_size, rounding = pole_rounding, anchor = CENTER);
            }

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
                    anchor = LEFT + FRONT + BOTTOM;
                    prismoid(size1 = size1, size2 = size2, shift = shift, h = h, anchor = anchor, orient = FRONT);
                }
                fwd(outer_depth) cuboid([ side_width * 2, pole_size, pole_size / 2 ], anchor = FRONT + TOP);
            }

            up(pole_size / 2) fwd(pole_size / 2 + drain_width / 2)
            {
                right(inner_half_width - pole_size / 3) roof_dovetail(true);
                right(outer_half_width) roof_dovetail(true);
            }
        }

        right(inner_half_width)
        {
            zflip_copy() up(pole_size / 2) zrot(90) female_connector();
            zflip() up(pole_size / 2) fwd(inner_depth) zrot(90) female_connector();
        }

        right(pole_break) yrot(-90) zrot(90)
        {
            female_connector();
            left(inner_depth) female_connector();
            left(outer_depth) female_connector();
        }

        up(pole_size / 2 + get_slop()) right(outer_half_width - pole_size)
        {
            fwd(inner_depth) zrot(90) roof_dovetail(false);
            fwd(outer_depth) zrot(90) roof_dovetail(false);
        }

        right(outer_half_width - pole_size * 3) front_sign_hook(true);
        panel_width = inner_half_width - (panel_pole_width + pole_size) / 2;
        down(pole_size / 2) right(panel_width) yrot(90) small_rectangle(true, pole_size / 2);
    }
}

module top_poles_2()
{
    module roof_dovetails()
    {
        fwd(inner_depth) zrot(90) roof_dovetail(false);
        fwd(outer_depth) zrot(90) roof_dovetail(false);
    }

    up(inner_height) difference()
    {
        union()
        {
            h = pole_break + get_connector_thickness() - get_slop();
            prismoid(pole_size, pole_size, rounding = pole_rounding, h = h, orient = RIGHT);
            fwd(inner_depth) prismoid(pole_size, pole_size, rounding = pole_rounding, h = h, orient = RIGHT);
            fwd(outer_depth) prismoid(pole_size, pole_size, rounding = pole_rounding, h = h, orient = RIGHT);
        }

        right(pole_break - get_slop()) yrot(90) zrot(90)
        {
            male_connector([ pole_size, pole_size ]);
            left(inner_depth) male_connector([ pole_size, pole_size ]);
            left(outer_depth) male_connector([ pole_size, pole_size ]);
        }

        up(pole_size / 2 + get_slop())
        {
            right(outer_half_width / 3 - pole_size) roof_dovetails();
            right(outer_half_width / 3 + pole_size) roof_dovetails();
        }

        right(outer_half_width / 2 - pole_size) front_sign_hook(true);
        right(outer_half_width / 2 + pole_size) front_sign_hook(true);
    }
}

module roof_dovetail(is_male)
{
    dovetail_modified(is_male, pole_size / 2);
}

module drain(is_male)
{
    module drain_main()
    {
        up(inner_height + pole_size / 2) fwd(pole_size / 2 + drain_width / 2) difference()
        {
            drain_length = outer_half_width + front_sign_overhang;
            size1 = [ drain_length, drain_width - get_slop(), back_slope_height - get_slop() ];
            cuboid(size1, anchor = LEFT + BOTTOM);
            size2 = [ back_slope_height / 2, drain_width - back_slope_height / 2 ];
            size3 = [ back_slope_height, drain_width - back_slope_height / 2 ];
            up(back_slope_height)
                prismoid(size1 = size2, size2 = size3, h = drain_length + 1, anchor = BOTTOM, orient = RIGHT);
            down(get_slop()) zflip()
            {
                right(inner_half_width - pole_size / 3) roof_dovetail(false);
                right(outer_half_width) roof_dovetail(false);
            }
        }
    }

    module mask(is_male)
    {
        up(inner_height + pole_size / 2 + back_slope_height) fwd(pole_size / 2 + drain_width / 2)
        {
            cuboid([ inner_half_width, drain_width + 1, back_slope_height + 1 ], anchor = LEFT + TOP);
            right(inner_half_width - pole_size) yrot(30)
                zcyl(r = pole_size * 3 / 2 + (is_male ? 0 : get_slop()), h = inner_height);
        }
    }

    if (is_male)
    {
        intersection()
        {
            drain_main();
            mask(true);
        }
    }
    else
    {
        difference()
        {
            drain_main();
            mask(false);
        }
    }
}

module roof(profile_anchor)
{
    unit_height = (front_sign_height - pole_size - front_slope_height) / cos(slope_angle) - roof_half_thickness * 2;
    small_unit_width = unit_height * sqrt(2) / 2;
    unit_width = unit_height * 2 + small_unit_width * 4;
    path = [
        [ -small_unit_width, 0, 0 ],
        [ small_unit_width, 0, 0 ],
        [ small_unit_width + unit_height, 0, unit_height ],
        [ small_unit_width * 3 + unit_height, 0, unit_height ],
        [ small_unit_width * 3 + unit_height * 2, 0, 0 ],
        [ unit_width + small_unit_width, 0, 0 ],
    ];

    up(inner_height + pole_size / 2 + back_slope_height) fwd(pole_size / 2 + drain_width / 2) intersection()
    {
        size = [ outer_half_width, outer_depth - drain_width / 2, front_sign_height - back_slope_height - pole_size ];
        cuboid(size, anchor = LEFT + BOTTOM + BACK);
        xcopies(unit_width, l = outer_half_width, sp = [ 0, 0, 0 ])
        {
            profile = rect([ outer_depth * 3, roof_half_thickness / cos(22.5) ], anchor = profile_anchor);
            fwd(drain_width / 2) xrot(-slope_angle) up(roof_half_thickness) path_sweep(profile, path);
        }
    }
}

module roof_1()
{
    module roof_dovetails()
    {
        fwd(inner_depth) zflip() zrot(90) roof_dovetail(true);
        fwd(outer_depth) zflip() zrot(90) roof_dovetail(true);
    }

    difference()
    {
        roof(BACK);
        up(inner_height) right(outer_half_width - get_slop())
            cuboid([ pole_size, outer_depth + drain_width, inner_height ], anchor = LEFT + BOTTOM + BACK);
    }

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

        right(outer_half_width - get_slop()) fwd(pole_size / 2 + drain_width)
        {
            side_width = pole_size / 2 - pole_rounding - get_slop();
            padding = front_sign_height - front_slope_height - pole_size - roof_half_thickness * 2 * cos(slope_angle);
            size1 = [ side_width, back_slope_height + padding ];
            size2 = [ side_width, front_slope_height + padding ];
            shift = [ 0, (front_slope_height - back_slope_height) / 2 ];
            h = outer_depth - drain_width;
            prismoid(size1 = size1, size2 = size2, shift = shift, h = h, anchor = RIGHT + FRONT + BOTTOM,
                     orient = FRONT);
        }

        right(outer_half_width - pole_size) roof_dovetails();
        right(outer_half_width / 3 - pole_size) roof_dovetails();
        right(outer_half_width / 3 + pole_size) roof_dovetails();
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

module roof_cut(is_male)
{
    difference()
    {
        union()
        {
            roof_1();
            roof_2();
        }
        size = [ outer_half_width, outer_depth * 2, front_sign_height ];
        up(inner_height) right(outer_half_width / 3 + (is_male ? -1 : 1) * get_slop() / 2)
            cuboid(size, anchor = (is_male ? LEFT : RIGHT) + BOTTOM + BACK);
    }
}