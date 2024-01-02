include <../libraries/gears.scad>
include <connector.scad>

pitch = 1.5;
teeth_small = 12;
teeth_big = 48;
helical = 30;

padding = 0.2;
spacing = 2;
gear_height = 6;
gear_distance = gear_dist(circ_pitch = pitch, teeth_small, teeth_big, helical = helical, backlash = 0.1);

motor_x = 20;
motor_y = 15.2;
motor_z = 28;
shell_x = 54;
shell_y = 36;
shell_z = gear_height * 2 + spacing * 6 + motor_z + padding * 2;
shell_offset = 8;

support_radius = 4;

module gear_1()
{
    spoke_size = 5;

    cube([ spoke_size, spoke_size, spoke_size * 2 ], center = true);
    zcyl(h = spacing, r = support_radius, anchor = TOP);
    down(spacing) zcyl(h = spacing * 2, r = support_radius + spacing, rounding2 = spacing, anchor = TOP);
    down(spacing * 3) big_gear();
}

module gear_2()
{
    right(gear_distance) down(spacing)
    {
        down(spacing * 2) small_gear(true);
        down(spacing * 3 + gear_height) big_gear();
        zcyl(h = spacing * 2, r = spacing, chamfer2 = spacing, anchor = TOP);
    }
}

module gear_3()
{
    motor_shaft_radius = 1.05;
    height = gear_height + spacing;

    motor_position(spacing * 4 + gear_height) difference()
    {
        union()
        {
            small_gear(false);
            down(gear_height) zcyl(h = spacing, r = motor_shaft_radius + spacing, anchor = TOP);
        }

        down(height / 2) zflip_copy() down(height / 4) zflip_copy()
            zcyl(h = height / 4, r1 = motor_shaft_radius, r2 = motor_shaft_radius + padding, anchor = BOTTOM);
    }
}

module shell_top()
{
    size = [ shell_x, shell_y ];
    vent_z = gear_height * 2 + spacing * 5 + 12;
    vent_size = 13;
    screw_support = 8;
    screw_diameter = 3;

    difference()
    {
        union()
        {
            right(shell_offset)
            {
                prismoid(size1 = size, size2 = size, height = spacing, rounding = support_radius, anchor = TOP);
                rect_tube(size = size, h = shell_z, wall = spacing, rounding = support_radius, anchor = TOP);
            }
            right(gear_distance) down(spacing)
                zcyl(h = spacing * 2 - padding, r = support_radius, rounding1 = spacing, anchor = TOP);
        }

        zcyl(h = spacing * 3, r = support_radius + padding);
        right(gear_distance) down(spacing * 2) zcyl(h = spacing * 3, r = spacing + padding);
        motor_position(vent_z) ycyl(h = motor_y * 2, d = vent_size);
    }

    difference()
    {
        screw_poles(spacing) zcyl(h = gear_height * 2 + spacing * 6, r = support_radius, anchor = TOP);
        screw_holes();
    }

    right(shell_offset) xflip_copy() down(shell_z) right((shell_x - screw_support) / 2) difference()
    {
        prismoid(size1 = [ screw_support, screw_support ], size2 = [ 0, screw_support ], height = screw_support,
                 shift = [ screw_support / 2, 0 ]);
        zcyl(d = screw_diameter, height = 1000);
    }
}

module shell_middle()
{
    motor_big_diameter = 8;
    support_radius_small = 2.5;

    shell_wrapper() difference()
    {
        union()
        {
            down(gear_height + spacing * 3 + padding * 2)
                zcyl(h = gear_height + spacing * 5 - padding * 2, r = support_radius_small,
                     rounding2 = support_radius_small - spacing, anchor = TOP);
            down(spacing * 3 + padding * 2) zcyl(h = gear_height, r = spacing, chamfer2 = spacing, anchor = TOP);

            down(gear_height * 2 + spacing * 4 + padding * 2) right(gear_distance)
                zcyl(h = spacing * 4 - padding * 2, r = support_radius_small,
                     rounding2 = support_radius_small - spacing, anchor = TOP);
            down(gear_height * 2 + spacing + padding * 2) right(gear_distance)
                zcyl(h = gear_height, r = spacing, chamfer2 = spacing, anchor = TOP);

            motor_position(gear_height * 2 + spacing * 5)
                cube([ motor_x + spacing * 2, motor_y + spacing * 2, spacing * 3 ], anchor = TOP);
            down(gear_height * 2 + spacing * 7) right(shell_offset) yflip_copy()
                zrot(atan2(shell_y - support_radius * 2 - spacing, shell_x - support_radius * 2 - spacing))
                    cube([ shell_x + shell_y, support_radius * 2, spacing ], anchor = TOP);
        }

        motor_position(gear_height * 2 + spacing * 5)
        {
            down(spacing) cube([ motor_x, motor_y, motor_z ], anchor = TOP);
            zcyl(h = spacing, d = motor_big_diameter, anchor = TOP);
        }

        screw_holes();
    }
}
module shell_bottom()
{
    size = [ shell_x, shell_y ];
    screw_support = 8;
    screw_diameter = 3;
    motor_wire = 8;
    gap = spacing * 8;

    difference()
    {
        union()
        {
            right(shell_offset) down(shell_z) difference()
            {
                prismoid(size1 = size, size2 = size, height = spacing, rounding = support_radius, anchor = TOP);
                xflip_copy() right((shell_x - screw_support) / 2) difference() zcyl(d = screw_diameter, height = 1000);
            }

            shell_wrapper() motor_position(gear_height * 2 + spacing * 5 + padding * 2 + gap)
                cube([ motor_x + spacing * 2, motor_y + spacing * 2, motor_z + spacing - gap ], anchor = TOP);
        }

        motor_position(gear_height * 2 + spacing * 6)
        {
            cube([ motor_x, motor_y, motor_z ], anchor = TOP);
            down(motor_z) fwd(motor_y / 2) cube([ motor_x, motor_y, motor_wire ], anchor = BOTTOM);
            zcyl(h = motor_z + spacing / 2, r = spacing, anchor = TOP);
        }
    }

    shell_wrapper() screw_poles(gear_height * 2 + spacing * 8)
        zcyl(h = gear_height * 2 + spacing * 6 + padding * 2, r = support_radius, anchor = TOP);

    screw_poles(gear_height * 2 + spacing * 5) zcyl(h = spacing * 3, r = spacing, rounding2 = spacing, anchor = TOP);
}

module small_gear(tall)
{
    difference()
    {
        down(gear_height / 2) spur_gear(pitch, teeth_small, gear_height + (tall ? spacing * 2 : 0), helical = helical,
                                        herringbone = true, slices = $fn / 10, gear_spin = 180 / teeth_small);
        cube([ 100, 100, 100 ], anchor = BOTTOM);
    }
}

module big_gear()
{
    difference()
    {
        down(gear_height / 2)
            spur_gear(pitch, teeth_big, gear_height, helical = -helical, herringbone = true, slices = $fn / 10);
        zcyl(h = gear_height, r1 = spacing + padding, r2 = spacing + padding * 2, anchor = TOP);
    }
}

module motor_position(down)
{
    motor_angle = asin((shell_y / 2 - spacing - motor_y / 2) / gear_distance);
    move([ gear_distance - gear_distance * cos(motor_angle), gear_distance * sin(motor_angle), -down ]) children();
}

module screw_poles(down)
{
    down(down) right(shell_offset) xcopies(shell_x - support_radius * 2 - spacing)
        ycopies(shell_y - support_radius * 2 - spacing) children();
}

module screw_holes()
{
    screw_poles(0) zcyl(h = 1000, r = padding + spacing);
}

module shell_wrapper()
{
    intersection()
    {
        children();
        right(shell_offset) cuboid([ shell_x - spacing * 2 - padding, shell_y - spacing * 2 - padding, 1000 ],
                                   rounding = support_radius - spacing);
    }
}