include <connector.scad>
include <libraries/gears.scad>

pitch = 3;
teeth_small = 16;
teeth_big = 48;
helical = 30;

padding = 0.2;
spacing = 2;
gear_height = 6;
gear_distance = gear_dist(circ_pitch = pitch, teeth_small, teeth_big, helical = helical, backlash = 0.1);
motor_angle = 30;

shell_height = gear_height * 2 + spacing * 6;
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
    right(gear_distance)
    {
        difference()
        {
            down(spacing * 3) small_gear(true);
            zcyl(h = spacing * 3, r = gear_distance, anchor = TOP);
        }

        down(spacing * 4 + gear_height) big_gear();
        down(spacing) zcyl(h = gear_height * 2, r = spacing, rounding = spacing, anchor = TOP);
    }
}

module gear_3()
{
    motor_shaft_radius = 1;

    right(gear_distance - gear_distance * cos(motor_angle)) fwd(gear_distance * sin(motor_angle))
    {
        down(spacing * 4 + gear_height) difference()
        {
            union()
            {
                small_gear(false);
                radius = motor_shaft_radius + spacing;
                down(gear_height) zcyl(h = spacing * 2, r = radius, rounding1 = spacing, anchor = TOP);
            }

            zcyl(h = gear_height + spacing * 2, r = motor_shaft_radius, anchor = TOP);
        }
    }
}

module shell_top()
{
    shell_x = 100;
    shell_z = 60;
    difference()
    {
        union()
        {
            right(20) difference()
            {
                cube([ shell_x, shell_z, shell_height ], anchor = TOP);
                down(spacing) cube([ shell_x - spacing * 2, shell_z - spacing * 2, shell_height ], anchor = TOP);
            }
            right(gear_distance) zcyl(h = spacing * 2, r = support_radius, anchor = TOP);
        }

        zcyl(h = spacing * 2, r = support_radius + padding, anchor = TOP);
        right(gear_distance) down(spacing * 2) small_sphere();
    }
}

module shell_bottom()
{
    motor_x = 21;
    motor_y = 15.5;
    motor_big_diameter = 6.5;
    height = 10;

    down(gear_height + spacing * 2) zcyl(h = spacing * 2, r = spacing, rounding2 = spacing, anchor = TOP);
    down(gear_height + spacing * 4) zcyl(h = gear_height + spacing + height, r = support_radius, anchor = TOP);

    right(gear_distance)
    {
        down(gear_height * 2 + spacing * 3) zcyl(h = spacing * 2, r = spacing, rounding2 = spacing, anchor = TOP);
        down(gear_height * 2 + spacing * 5) zcyl(h = height, r = support_radius, anchor = TOP);

        left(gear_distance * cos(motor_angle)) fwd(gear_distance * sin(motor_angle))
        {
            down(spacing * 5 + gear_height * 2)
            {
                difference()
                {
                    cube([ motor_x + spacing * 2, motor_y + spacing * 2, height ], anchor = TOP);
                    down(spacing) cube([ motor_x, motor_y, height ], anchor = TOP);
                    zcyl(h = spacing, d = motor_big_diameter, anchor = TOP);
                }
            }
        }
    }
}

module small_gear(add_height)
{
    height = gear_height + (add_height ? spacing * 2 : 0);
    spin = 180 / teeth_small + (add_height ? 0 : motor_angle);
    down(gear_height / 2) spur_gear(pitch, teeth_small, height, helical = helical, herringbone = true,
                                    slices = $fn / 10, gear_spin = spin);
}

module big_gear()
{
    down(gear_height / 2) difference()
    {
        spur_gear(pitch, teeth_big, gear_height, helical = -helical, herringbone = true, slices = $fn / 10);
        down(gear_height / 2) small_sphere();
    }
}

module small_sphere()
{
    spheroid(r = spacing + padding, style = "icosa", $fn = $fn / 5);
}

gear_1();
gear_2();
gear_3();
shell_top();
shell_bottom();