include <../../openscad/libraries/std.scad>
include <constants.scad>
include <technic_parts.scad>

$fn = $preview ? 16 : 64;
thickness = 1.2;
width = 2.5;

module outside()
{
    difference()
    {
        union()
        {
            technic_beam(5);
            cuboid([ lego_unit * 3, lego_unit - get_slop(), lego_unit - get_slop() ]);
        }
        up(thickness) fwd(0.5) cuboid([ lego_unit * 3, width + 1, lego_unit ]);
    }
}

module inside()
{
    down(lego_unit / 2 - thickness)
    {
        difference()
        {
            size = [ lego_unit * 3 - get_slop(), width - get_slop() + 1, lego_unit - thickness - get_slop() ];
            up(get_slop() / 2) fwd(0.5) cuboid(size, anchor = BOTTOM);
            // Reed sensor
            cuboid([ 15, width, width ], anchor = BOTTOM);
            // Top space
            up(3) cuboid([ 15, width, 3 ], anchor = BOTTOM);
            // Wire hole
            up(5) cuboid([ 2, 2, 2 ], anchor = BOTTOM + FRONT);
            // Side pin loop
            fwd(0.5)
            {
                shift = lego_unit * 3 - 2;
                up(1) cuboid([ shift, 2, 1 ], anchor = BOTTOM + FRONT);
                up(3) cuboid([ shift, 2, 3 ], anchor = BOTTOM + FRONT);
                xflip_copy() up(1) right(shift / 2) cuboid([ 2, 2, 3 ], anchor = BOTTOM + RIGHT + FRONT);
            }
        }
    }
}

top_half(z = (get_slop() - lego_unit) / 2 + 0.8) outside();
inside();