include <../../openscad/libraries/std.scad>

display_length = 262;
display_height = 33;
screen = 0.4;
esp_length = 70;
esp_height = 26;
depth = 19;
wall = 2;
led_backing = 6.5;
connector = 8;
padding = 0.2;

$fn = 32;

module led_holder()
{
    back(display_height + wall / 2) yflip_copy() fwd(wall / 2) children();
}

module screw_holes(even = true)
{
    xcopies((display_length - connector * 2) / 3, n = even ? 4 : 3) back(display_height + wall - connector / 2)
        children();
}
module esp_cut()
{
    cuboid([ esp_length, wall * 3, depth ], anchor = BOTTOM);
}

module case_front()
{
    difference()
    {
        union()
        {
            // LED holder
            led_holder()
            {
                cuboid([ display_length + wall * 2, display_height + wall * 2, screen ], anchor = TOP + FRONT);
                difference()
                {
                    rect_tube(isize = [ display_length, display_height ], wall = wall, h = depth + wall,
                              anchor = BOTTOM + FRONT);
                    // Cut back wall
                    up(depth) cuboid([ display_length, display_height * 2, wall + 1 ], anchor = BOTTOM + FRONT);
                    // Cut LED short divider
                    up(5) cuboid([ display_length, display_height, depth ], anchor = BOTTOM);
                }

                // Screw holes
                up(depth) screw_holes() difference()
                {
                    prismoid(size1 = [ connector, 0 ], size2 = [ connector, connector ], shift = [ 0, -connector / 2 ],
                             h = led_backing, anchor = TOP);
                    zcyl(depth, d = 3);
                }
            }

            // ESP holder
            cuboid([ esp_length + wall * 2, esp_height + wall * 2, screen ], anchor = TOP + BACK);
            rect_tube(isize = [ esp_length, esp_height ], wall = wall, h = depth, anchor = BOTTOM + BACK);
        }

        // Cut ESP dividing wall
        esp_cut();
        wire_hole();
    }
}

module case_back()
{
    difference()
    {
        up(depth)
        {
            // LED cover
            led_holder()
            {
                difference()
                {
                    cuboid([ display_length - padding * 2, display_height + wall * 2, wall ], anchor = BOTTOM + FRONT);
                    screw_holes()
                    {
                        zcyl(depth, d = 3);
                        up(wall / 2) zcyl(wall, d = 7, anchor = BOTTOM);
                    }
                }

                screw_holes(false) back(wall - padding) cuboid([ 60, wall, wall ], anchor = TOP + FRONT);

                // LED backing
                xcopies(display_length / 2, n = 2)
                {
                    back(display_height / 2 + wall) cuboid([ 100, 15, led_backing ], anchor = TOP);
                }
            }

            // ESP cover
            cuboid([ esp_length + wall * 2, esp_height + wall * 2, wall ], anchor = BOTTOM + BACK);
            xflip_copy() left(esp_length / 2 - padding)
                cuboid([ wall, esp_height + wall - padding, wall ], anchor = TOP + BACK + LEFT);
        }

        // Hangers
        up(depth) back(display_height / 2) xcopies(display_length * 2 / 3, n = 2)
        {
            prismoid(size1 = [ 7, 14 ], size2 = [ 7, 14 ], rounding = 3.5, h = 3, anchor = TOP);
            prismoid(size1 = [ 4, 11 ], size2 = [ 4, 11 ], rounding = 2, h = wall + 1, anchor = BOTTOM);
            back(3.5) zcyl(wall + 1, d = 7, anchor = BOTTOM);
        }

        // Cut ESP dividing wall
        esp_cut();
        wire_hole();
    }
}

module wire_hole()
{
    back(display_height * 2 + wall * 2) up(depth + wall) left(display_length / 2) xrot(45)
        cuboid([ 4, depth, 1.5 ], anchor = LEFT);
}

case_front();
case_back();