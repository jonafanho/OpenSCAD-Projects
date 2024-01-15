include <../libraries/rounding.scad>
include <../libraries/std.scad>

scale = 1 / 13;
inside = false;

module traffic_light(lights)
{
    rounding_radius = 8;
    sweep_rounding = os_circle(rounding_radius);
    sweep_fn = $fn == 0 ? 16 : $fn / 4;

    function length(large) = large ? 252 : 184;
    function width(large) = large ? 350 : 269;
    function height(large) = large ? 355 : 284;
    function shape(large) = let(ratio = 149 / 101.5) round_corners(
        [
            [ width(large) / 2, length(large) ],
            [ width(large) / 2, ratio * (large ? 142 : 101.5) ],
            [ 33, 0 ],
            [ -33, 0 ],
            [ -width(large) / 2, ratio * (large ? 142 : 101.5) ],
            [ -width(large) / 2, length(large) ],
        ],
        radius = rounding_radius);

    module light(large)
    {
        module center_point()
        {
            up(height(large) / 2) back(length(large)) xrot(90) children();
        }

        difference()
        {
            offset_sweep(shape(large), height = height(large), bottom = sweep_rounding, top = sweep_rounding,
                         steps = sweep_fn);
            center_point() cyl(r = large ? 145 : 102, h = 40);
        }

        center_point() difference()
        {
            radius1 = large ? 140 : 104;
            radius2 = large ? 165 : 122;
            cover = large ? 283 : 227;
            indent = large ? 64 : 25;
            thickness = 10; // 4;
            path = [
                [ thickness, -radius2 / 2 ],
                [ thickness, -radius2 ],
                [ cover + 1, -radius2 - 1 ],
                [ cover, radius1 ],
                [ cover - indent, -radius2 / 2 + (cover - indent) / 4 ],
            ];

            tube(ir1 = radius1 - thickness, ir2 = radius2 - thickness, or1 = radius1, or2 = radius2, height = cover,
                 anchor = TOP);
            xflip_copy() yrot(90) linear_extrude(radius1 * 2) polygon(round_corners(path, radius = [ 0, 0, 0, 0, 20 ]));
        }
    }

    module base()
    {
        difference()
        {
            union()
            {
                down(rounding_radius)
                    offset_sweep(shape(false), height = rounding_radius, top = sweep_rounding, steps = sweep_fn);
                shapes = [
                    apply(back(90), circle(r = 36)),
                    shape(false),
                ];
                layers = [
                    -23,
                    -rounding_radius,
                ];
                skin(shapes, z = layers, slices = 0, method = "tangent");
            }

            back(90) cyl(r = 36, h = 30, chamfer2 = 10, anchor = TOP);
        }
    }

    module conditional_cut()
    {
        if (inside)
        {
            intersection()
            {
                children(0);
                children(1);
            }
        }
        else
        {
            difference()
            {
                children(0);
                children(1);
            }
        }
    }

    last_index = len(lights) - 1;
    offsets = cumsum([for (i = lights) height(i) * scale]);
    total_height = offsets[last_index];

    module pole()
    {
        module main_tube(height)
        {
            tube(od = 10, id = 4.5, h = height, anchor = BOTTOM);
        }

        base_height = 23 * scale;
        absolute_height = height(true) * 3 * scale + 8;
        cap_height = 8;

        zflip_copy(z = total_height / 2) down(base_height) conditional_cut()
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
                up(total_height + base_height)
                {
                    remaining_height = absolute_height - total_height - base_height;

                    difference()
                    {
                        main_tube(remaining_height);
                        up(4) yscale(3) cuboid([ 3, 3, 3 ], chamfer = 2, edges = FRONT + TOP, anchor = BOTTOM + FRONT);
                    }

                    up(remaining_height) zscale(0.5)
                        cyl(d = 12, h = cap_height * 2, rounding1 = 1, rounding2 = 6, anchor = BOTTOM);
                }

                bottom_height = 248 - cap_height - absolute_height - base_height + 2;

                down(bottom_height) difference()
                {
                    union()
                    {
                        main_tube(bottom_height - base_height - 4);
                        tube(id = 4.5, od = 50, h = 3, anchor = BOTTOM);
                    }

                    cube([ 5, 25, 2 ], anchor = BOTTOM + FRONT);
                }
            }
        }
    }

    module lights()
    {
        difference()
        {
            conditional_cut()
            {
                union()
                {
                    scale(scale) base();
                    for (i = [0:last_index])
                    {
                        large = lights[i];

                        up(i == 0 ? 0 : offsets[i - 1]) difference()
                        {
                            scale(scale) light(large);

                            ratio = 8.5 / 6;
                            depth = large ? 11 : 6;
                            up(height(large) / 2 * scale)
                            {
                                back(7) ycyl(d1 = 6, d2 = 6 + depth * ratio, h = depth, anchor = FRONT);
                                xflip_copy() back(5) left(2.54 / 2) ycyl(d = 1, h = 3, anchor = FRONT);
                            }
                        }
                    }
                    up(total_height) zflip() scale(scale) base();
                }

                padding = inside ? 0.5 : 0;
                up(padding / 2) back(padding / 2) union()
                {
                    back(5) cube([ 6 - padding, 8 - padding, total_height * 2 ], anchor = BOTTOM + FRONT);
                    up(total_height) back(2) cube([ 6 - padding, 3, total_height ], anchor = BOTTOM + FRONT);
                }
            }

            back(4) cube([ 4, 2, total_height ], anchor = BOTTOM + FRONT);
            back(2) yscale(1.5) cuboid([ 6, 2, total_height ], chamfer = 2, edges = [ FRONT + LEFT, FRONT + RIGHT ],
                                       anchor = BOTTOM + FRONT);
            up(total_height) back(90 * scale) cyl(d1 = 2, d2 = 4, h = 10, shift = [ 0, 2 ], anchor = TOP);
        }
    }

    pole();
    lights();
}

traffic_light([ true, false, false ]);