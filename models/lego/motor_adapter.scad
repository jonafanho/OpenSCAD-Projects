include <../../openscad/libraries/std.scad>
include <constants.scad>
include <technic_parts.scad>

$fn = $preview ? 16 : 64;

module adapter()
{
    space = lego_unit * 2;
    motor_length = 20;
    motor_width = 15.1;
    motor_height = 25.2;
    motor_diameter_1 = 6.2;
    motor_diameter_2 = 10;

    difference()
    {
        union()
        {
            zcopies(lego_unit * 3, 2)
            {
                fwd((space + lego_unit) / 2) technic_beam(3);
                back((space + lego_unit) / 2) technic_beam(3);
                zrot(90)
                {
                    fwd(space / 2) technic_beam(4);
                    back(space / 2) technic_beam(4);
                }
            }

            fwd(lego_unit * 3 / 2) up(lego_unit * 3 / 2) technic_beam(5);
            cuboid([ lego_unit * 3 - get_slop(), space - get_slop(), lego_unit * 4 - get_slop() ]);
            up(lego_unit + get_slop() / 2) fwd(lego_unit * 3 / 2)
                cuboid([ lego_unit * 3, lego_unit - get_slop(), lego_unit - get_slop() ], anchor = BOTTOM);
        }

        // Middle hole
        ycyl(lego_unit, d = 10, anchor = FWD);
        // Main motor space
        cuboid([ motor_length, motor_width, motor_height ]);
        // Wire connection
        fwd(motor_width / 2) cuboid([ motor_length - 4, 4, motor_height / 2 ], anchor = BOTTOM);
        // Bottom hole
        down(lego_unit * 2) cyl(lego_unit, d = motor_diameter_1);
        // Top hole
        up(lego_unit * 2) cyl(lego_unit, d = motor_diameter_2);
    }
}

module axle()
{
    axle_height = lego_unit - 2;

    intersection()
    {
        down(axle_height / 2) zcopies(axle_height / 2, 2) zflip_copy() zrot_copies(n = 4)
        {
            right(1) yrot(-10) cuboid([ 1, 1.5, axle_height / 4 + 0.5 ], anchor = TOP + LEFT);
            right(3) down(axle_height / 4) cuboid([ 2, 1.5, 1 ], anchor = BOTTOM);
        }
        cuboid([ 6, 6, axle_height ], anchor = TOP);
    }

    top_half(z = -axle_height) difference()
    {
        cyl(lego_unit * 2 - get_slop(), d = lego_unit - get_slop());
        cyl(lego_unit, d = 5, anchor = TOP);
        up(lego_unit / 2) technic_axle_hole();
    }
}

bottom_half(z = -get_slop()) adapter();
top_half(z = get_slop()) adapter();
axle();