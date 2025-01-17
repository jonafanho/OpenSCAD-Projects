include <../../openscad/libraries/std.scad>
include <constants.scad>

module technic_hole()
{
    outer_diameter = 6.2 + get_slop();
    inner_diameter = 4.8 + get_slop();
    thickness = 0.8;
    zflip_copy() down((lego_unit - get_slop()) / 2) cyl(d = outer_diameter, h = thickness * 2);
    cyl(d = inner_diameter, h = lego_unit);
}

module technic_beam(holes)
{
    size = lego_unit - get_slop();
    length = (holes - 1) * lego_unit;
    difference()
    {
        union()
        {
            xcopies(length, 2) cyl(d = size, h = size);
            cyl(d = size, h = size);
            cuboid([ length, size, size ]);
        }
        xcopies(lego_unit, holes) technic_hole();
    }
}

module technic_axle_hole()
{
    width = 1.8 + get_slop();
    height = 4.8 + get_slop();
    cuboid([ width, height, lego_unit ]);
    cuboid([ height, width, lego_unit ]);
}