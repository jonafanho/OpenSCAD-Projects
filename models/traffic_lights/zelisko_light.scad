include <zelisko_base.scad>

function shape(large) = let(ratio = 149 / 101.5) round_corners(
    [
        [ width(large) / 2, length(large) ],
        [ width(large) / 2, ratio *(large ? 142 : 101.5) ],
        [ 33, 0 ],
        [ -33, 0 ],
        [ -width(large) / 2, ratio *(large ? 142 : 101.5) ],
        [ -width(large) / 2, length(large) ],
    ],
    radius = rounding_radius);

module light(large)
{
    module center_point()
    {
        up(height(large) / 2) back(length(large)) xrot(90) children();
    }

    // Main body
    difference()
    {
        offset_sweep(shape(large), height(large), sweep_rounding, sweep_rounding, steps = sweep_fn);
        center_point() cyl(r = large ? 145 : 102, h = 40);
    }

    // Cover
    center_point() difference()
    {
        radius1 = large ? 140 : 104;
        radius2 = large ? 165 : 122;
        length = large ? 283 : 227;
        indent = large ? 64 : 25;
        thickness = 10; // Should be 4, but it's too thin to 3D print
        path = [
            [ thickness, -radius2 / 2 ],
            [ thickness, -radius2 ],
            [ length + 1, -radius2 - 1 ],
            [ length, radius1 ],
            [ length - indent, -radius2 / 2 + (length - indent) / 4 ],
        ];

        tube(length, ir1 = radius1 - thickness, ir2 = radius2 - thickness, or1 = radius1, or2 = radius2, anchor = TOP);
        xflip_copy() yrot(90) linear_extrude(radius1 * 2) polygon(round_corners(path, radius = [ 0, 0, 0, 0, 20 ]));
    }
}

module base()
{
    difference()
    {
        union()
        {
            down(rounding_radius) offset_sweep(shape(false), rounding_radius, top = sweep_rounding, steps = sweep_fn);
            shapes = [
                apply(back(90), circle(r = 36)),
                shape(false),
            ];
            layers = [
                -base_height,
                -rounding_radius,
            ];
            skin(shapes, z = layers, slices = 0, method = "tangent");
        }

        back(90) cyl(r = 36, h = 30, chamfer2 = 10, anchor = TOP);
    }
}