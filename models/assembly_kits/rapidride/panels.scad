include <../../libraries/std.scad>
include <constants.scad>

panel_bottom = dimension_scale(17);
panel_middle = dimension_scale(29);
panel_top = dimension_scale(85);
panel_depth = dimension_scale(34.5);
panel_pole_width = dimension_scale(3);
panel_pole_offset = (panel_pole_width + pole_size) / 2;
panel_width = inner_half_width - panel_pole_offset;

frame_depth = panel_pole_width / 2;
frame_rim = frame_depth / 2;
grate_depth = panel_pole_width / 4;
grate_rim = panel_pole_width / 3;

sign_support_size = dimension_scale(3);
sign_bottom_bound = panel_top + panel_pole_thickness / 2 + sign_support_size;
sign_top_bound = inner_height - pole_size / 2 - sign_support_size;
sign_width = inner_half_width - panel_pole_width - sign_support_size - pole_size / 2;
sign_height = sign_top_bound - sign_bottom_bound;
sign_depth = panel_pole_width / 3;

handrail_diameter = dimension_scale(4);
handrail_offset_x = dimension_scale(8);
handrail_offset_y = dimension_scale(5);
handrail_offset_z = dimension_scale(5);
handrail_support_width = dimension_scale(0.75);

module common_panel_pole()
{
    up(panel_middle) right(panel_width)
    {
        size1 = [ panel_pole_width, panel_pole_width, pole_size ];
        down(panel_pole_thickness / 2) cuboid(size1, rounding = panel_pole_rounding, anchor = BOTTOM);
        size2 = [ panel_pole_width, panel_pole_width ];
        prismoid(size2, size2, rounding = panel_pole_rounding, h = inner_height - panel_middle - pole_size / 2);
    }
}

module back_panel()
{
    size1 = [ panel_pole_thickness, panel_pole_width ];
    h = inner_half_width - pole_size / 2;
    up(panel_bottom) prismoid(size1, size1, rounding = panel_pole_rounding, h = h, orient = RIGHT);
    up(panel_middle) prismoid(size1, size1, rounding = panel_pole_rounding, h = panel_width, orient = RIGHT);
    up(panel_top) prismoid(size1, size1, rounding = panel_pole_rounding, h = panel_width, orient = RIGHT);

    up((panel_bottom + panel_top) / 2) right(panel_width / 4)
    {
        total_height = panel_top - panel_bottom + panel_pole_thickness;
        size2 = [ panel_pole_thickness, panel_pole_width, total_height ];
        cuboid(size2, rounding = panel_pole_rounding);
        right(panel_width / 2) cuboid(size2, rounding = panel_pole_rounding);
    }

    common_panel_pole();
    frames(panel_bottom, panel_middle, grate_rim, grate_depth, 0);
}

module side_panels()
{
    right(panel_width)
    {
        size1 = [ panel_pole_width, panel_pole_thickness ];
        up(panel_middle) prismoid(size1, size1, rounding = panel_pole_rounding, h = panel_depth, orient = FORWARD);
        up(panel_top) prismoid(size1, size1, rounding = panel_pole_rounding, h = panel_depth, orient = FORWARD);
        size2 = [ panel_pole_width, panel_pole_thickness, panel_top - panel_middle + panel_pole_thickness ];
        up((panel_middle + panel_top) / 2) fwd(panel_depth) cuboid(size2, rounding = panel_pole_rounding);
    }

    common_panel_pole();
}

module frames(bottom_level, top_level, rim, depth, end_offset)
{
    up((bottom_level + top_level) / 2)
    {
        panel_height = top_level - bottom_level - panel_pole_thickness;
        size1 = [ panel_width / 2 - panel_pole_thickness, panel_height ];
        right_half(s = top_level - bottom_level)
            rect_tube(size = size1, wall = rim, h = depth, anchor = CENTER, orient = FRONT);
        right(panel_width / 2) rect_tube(size = size1, wall = rim, h = depth, anchor = CENTER, orient = FRONT);
        end_width = panel_width / 4 - panel_pole_thickness / 2 - panel_pole_width / 2 + panel_pole_width - end_offset;
        size2 = [ end_width, panel_height ];
        right(inner_half_width - pole_size / 2 - end_offset)
            rect_tube(size = size2, wall = rim, h = depth, anchor = RIGHT, orient = FRONT);
    }
}

module back_frames()
{
    color_this("firebrick") frames(panel_middle, panel_top, frame_rim, frame_depth, panel_pole_width);
}

module side_frames()
{
    total_depth = panel_depth - panel_pole_thickness / 2;
    color_this("firebrick") right(panel_width) up((panel_middle + panel_top) / 2) fwd(total_depth)
    {
        size = [ panel_top - panel_middle - panel_pole_thickness, total_depth - panel_pole_width / 2 ];
        rect_tube(size = size, wall = frame_rim, h = frame_depth, anchor = FRONT, orient = RIGHT);
    }
}

module back_sign_panels()
{
    yflip_copy() fwd(sign_depth)
    {
        white_line_top = (sign_bottom_bound + sign_top_bound) / 2 - sign_support_size / 2;
        white_line_bottom = white_line_top - sign_height / 64;
        size1 = [ sign_width, sign_depth, white_line_bottom - sign_bottom_bound ];
        size2 = [ sign_width, sign_depth, white_line_top - white_line_bottom ];
        size3 = [ sign_width, sign_depth, sign_top_bound - white_line_top ];
        color_this("black") up(sign_bottom_bound) cuboid(size1, anchor = LEFT + BOTTOM);
        color_this("white") up(white_line_bottom) cuboid(size2, anchor = LEFT + BOTTOM);
        color_this("firebrick") up(white_line_top) cuboid(size3, anchor = LEFT + BOTTOM);
    }
}

module back_sign_support()
{
    up((sign_bottom_bound + sign_top_bound) / 2)
    {
        cuboid([ sign_width - panel_pole_rounding, sign_depth, sign_height - panel_pole_rounding * 2 ], anchor = LEFT);
        cuboid([ sign_width + sign_support_size, sign_depth, sign_support_size ], anchor = LEFT);
    }
}

module handrail()
{
    color_this("darkgray") up(panel_middle + handrail_offset_z) fwd(handrail_offset_y)
    {
        cyl(inner_half_width - handrail_offset_x, d = handrail_diameter, anchor = BOTTOM, orient = RIGHT);
        size = [ handrail_support_width, handrail_offset_y - panel_pole_width / 2, handrail_diameter ];
        right(panel_width / 4) cuboid(size, anchor = FRONT);
        right(panel_width * 3 / 4) cuboid(size, anchor = FRONT);
    }
}