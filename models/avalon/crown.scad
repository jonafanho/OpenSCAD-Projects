include <../../openscad/libraries/std.scad>

layer = 0;

module crown()
{
    step = $fn == 0 ? 10 : $fn;

    module spike_profile(radius, angle)
    {
        points = [for (i = [-angle:angle / max(1, round(angle / 5)):angle])[radius * cos(i), radius * sin(i)]];
        stroke(points, 4, joints = "square");
    }

    if (layer == 0)
    {
        up(4) tube(or = 19, ir = 15, h = 12, anchor = BOTTOM);
        layer_height = 20 / step;
        spike_height = 15;

        zrot_copies(n = 6) for (i = [0:layer_height / spike_height:1])
        {
            if (i < 1)
            {
                up(20 + i * spike_height) linear_extrude(layer_height) spike_profile(i * 9 + 17, -20 * sqrt(i) + 20);
            }
        }
    }
    else if (layer == 1)
    {
        difference()
        {
            union()
            {
                cyl(r = 20, h = 4, rounding = 1, anchor = BOTTOM);
                up(16) cyl(r = 20, h = 4, rounding = 1, anchor = BOTTOM);
            }
            down(1) cyl(r = 15, h = 22, anchor = BOTTOM);
        }

        zrot_copies(n = 6) up(34.5) left(26) difference()
        {
            sphere(r = 4, anchor = BOTTOM);
            cube([ 10, 10, 0.5 ], anchor = BOTTOM);
        }
    }
}

crown();