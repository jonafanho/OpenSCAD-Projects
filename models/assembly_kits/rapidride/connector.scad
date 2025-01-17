include <../../libraries/joiners.scad>
include <../../libraries/std.scad>

thickness = 1.5;

function get_connector_thickness() = thickness;

module axle(is_hole, rotation, anchor = CENTER)
{
    length = 1.5 + (is_hole ? get_slop() * 2 : 0);
    width = 2 + (is_hole ? get_slop() : 0);
    height = 10 + (is_hole ? get_slop() * 2 : 0);
    shift = anchor[2] * (is_hole ? get_slop() : 0);
    zrot_copies(n = 3) zrot(rotation) up(shift) cuboid([ length, width, height ], anchor = [ 0, 1, anchor[2] ]);
}

module front_sign_hook(is_hole)
{
    padding = is_hole ? get_slop() : 0;
    up(pole_size / 2 + padding / 2) fwd(outer_depth)
    {
        cuboid([ pole_size / 2 + padding, pole_size / 2 + padding, pole_size / 4 + padding ], anchor = BACK + TOP);
        cuboid([ pole_size / 2 + padding, pole_size / 4 + padding, pole_size / 2 + padding ], anchor = TOP);
    }
}

module small_rectangle(is_hole, length)
{
    padding = is_hole ? get_slop() : 0;
    cuboid([ length + padding, 3 + padding, 2 + padding ]);
}

module dovetail_modified(is_male, slide)
{
    dovetail(is_male ? "male" : "female", slide = slide + (is_male ? 0 : get_slop()), width = 2, height = 1.5);
}

module snap_pin_modified()
{
    snap_pin("medium", pointed = false);
}

module snap_pin_socket_modified()
{
    if ($preview)
    {
        up(1) cuboid([ 4, 2, 5 ], anchor = TOP);
    }
    else
    {
        snap_pin_socket("medium", pointed = false, l = 7.8);
    }
}

module female_connector()
{
    up(1) regular_prism(6, r = 3.5 + get_slop(), h = thickness + 1 + get_slop(), spin = 30, anchor = TOP);
    down(thickness) snap_pin_socket_modified();
}

module male_connector(size)
{
    difference()
    {
        prismoid(size + [ 1, 1 ], size + [ 1, 1 ], h = thickness + 1, anchor = BOTTOM);
        intersection()
        {
            regular_prism(6, r = 3.5, h = thickness, spin = 30, anchor = BOTTOM);
            prismoid([ 7, 7 ], [ 7, 5 ], h = thickness);
        }
    }
    up(thickness) snap_pin_socket_modified();
}

module test_connectors(size)
{
    left(5) difference()
    {
        cuboid([ size, size, 10 ], anchor = TOP);
        female_connector();
    }
    right(5) difference()
    {
        up(get_connector_thickness()) cuboid([ size, size, 10 + get_connector_thickness() ], anchor = TOP);
        male_connector([ size, size ]);
    }
}