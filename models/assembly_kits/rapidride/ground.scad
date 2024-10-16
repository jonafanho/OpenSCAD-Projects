include <../../libraries/std.scad>
include <connector.scad>
include <constants.scad>

legs_pole_size = dimension_scale(3.5);
legs_flat_size = dimension_scale(12);
legs_flat_thickness = dimension_scale(1);
ground_thickness = 2;

module ground()
{
    color_this("gray") difference()
    {
        offset = legs_flat_size / 2 + 1;
        size1 = [ inner_half_width + offset, outer_depth + offset, ground_thickness ];
        chamfer1 = outer_depth - inner_depth;
        back(offset) cuboid(size1, chamfer = chamfer1, edges = [FORWARD + RIGHT], anchor = LEFT + BACK + TOP);
        size2 = [ inner_half_width - offset + 1, outer_depth - offset * 3, ground_thickness * 2 + 1 ];
        chamfer2 = outer_depth - inner_depth - offset * 2 + offset * 2 * tan(22.5);
        fwd(offset) left(1) cuboid(size2, chamfer = chamfer2, edges = [FORWARD + RIGHT], anchor = LEFT + BACK);
    }

    right(inner_half_width) difference()
    {
        union()
        {
            cuboid([ legs_flat_size, legs_flat_size, legs_flat_thickness ], anchor = BOTTOM);
            h = legs_height + get_connector_thickness();
            prismoid(legs_pole_size, legs_pole_size, rounding = pole_rounding, h = h);
            fwd(inner_depth) prismoid(legs_pole_size, legs_pole_size, rounding = pole_rounding, h = h);
        }

        up(legs_height)
        {
            zrot(90) male_connector([ pole_size, pole_size ]);
            fwd(inner_depth) zrot(90) male_connector([ pole_size, pole_size ]);
        }
    }
}