include <zelisko_light.scad>

scale = 1 / 13;
lights = [ true, false, false ];
layer = 2;

height_from_ground = 196-150;
pole_height = 292-150;
last_index = len(lights) - 1;
offsets = cumsum([for (i = lights) height(i) * scale]);
total_height = offsets[last_index];

module lights(inside)
{
    up(height_from_ground) difference()
    {
        conditional_cut(inside)
        {
            union()
            {
                scale(scale) base();
                for (i = [0:last_index])
                {
                    large = lights[i];
                    up(i == 0 ? 0 : offsets[i - 1]) difference()
                    {
                        // Main body
                        scale(scale) light(large);
                        // Middle cone and LED holes
                        ratio = 8.5 / 6;
                        depth = large ? 11 : 6;
                        up(height(large) / 2 * scale)
                        {
                            back(7) ycyl(depth, d1 = 6, d2 = 6 + depth * ratio, anchor = FRONT);
                            xflip_copy() back(5) left(2.54 / 2) ycyl(3, d = 1, anchor = FRONT);
                        }
                    }
                }
                up(total_height) zflip() scale(scale) base();
            }

            // Middle cutout
            padding = inside ? 0.5 : 0;
            up(padding / 2) back(padding / 2) union()
            {
                back(5) cube([ 6 - padding, 8 - padding, total_height * 2 ], anchor = BOTTOM + FRONT);
                up(total_height) back(2) cube([ 6 - padding, 3, total_height ], anchor = BOTTOM + FRONT);
            }
        }

        // Top connecting hole
        back(4) cube([ 4, 2, total_height ], anchor = BOTTOM + FRONT);
        edges = [ FRONT + LEFT, FRONT + RIGHT ];
        back(2) yscale(1.5) cuboid([ 6, 2, total_height ], chamfer = 2, edges = edges, anchor = BOTTOM + FRONT);
        up(total_height) back(90 * scale) cyl(10, d1 = 2, d2 = 4, shift = [ 0, 2 ], anchor = TOP);
    }
}

module pole(inside)
{
    module main_tube(height)
    {
        tube(od = 10, id = 4.5, h = height, anchor = BOTTOM);
    }

    up(height_from_ground) zflip_copy(z = total_height / 2) down(base_height * scale) conditional_cut(inside)
    {
        padding = inside ? 0 : 0.2;

        union()
        {
            back(90 * scale) difference()
            {
                union()
                {
                    up(1.5) cyl(r = 36 * scale, h = 3.5, chamfer2 = 1, anchor = TOP);
                    cube([ 4, 12 + 90 * scale, 2 ], anchor = TOP + BACK);
                }
                cyl(d = 3, h = 10);
            }

            difference()
            {
                down(4) fwd(15) main_tube(total_height / 2 + 4 + base_height);
                up(7.5) fwd(11.5 - padding / 2) xrot(-45) cube([ 4 + padding, 2, 2 ], anchor = BOTTOM + FRONT);
            }
        }

        down(2) union()
        {
            fwd(12 + padding / 2) cuboid([ 4 + padding, 2 + padding / 2, 10 + padding / 2 ], chamfer = 2,
                                         edges = TOP + BACK, anchor = BOTTOM + FRONT);
            fwd(14) down(padding / 2) cube([ 4 + padding, 4, 2 + padding ], anchor = BOTTOM + FRONT);
            fwd(10) cube([ 6, 20, 8 ], anchor = BOTTOM + FRONT);
        }
    }

    if (!inside)
    {
        fwd(15)
        {
            support_height = 3;
            top_height = height_from_ground + total_height + base_height * scale + 4;

            up(support_height) main_tube(height_from_ground - support_height - base_height * scale - 4);
            up(top_height)
            {
                difference()
                {
                    main_tube(pole_height - top_height);
                    fwd(1) up(2) cuboid([ 4, 6, 6 ], chamfer = 6, edges = FRONT + TOP, anchor = BOTTOM + FRONT);
                }

                cap_height = 8;
                up(pole_height - top_height) zscale(0.5)
                    cyl(cap_height * 2, d = 12, rounding1 = 1, rounding2 = 6, anchor = BOTTOM);
            }

            difference()
            {
                tube(support_height, id = 4.5, od = 50, anchor = BOTTOM);
                cube([ 5, 25, 2 ], anchor = BOTTOM + FRONT);
            }
        }
    }
}

// lights(false);
$fn=100;
pole(false);