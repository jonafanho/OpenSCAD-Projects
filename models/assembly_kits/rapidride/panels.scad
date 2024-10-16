include <../../libraries/std.scad>
include <connector.scad>
include <constants.scad>

panel_depth = dimension_scale(34.5);
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

module side_holes()
{
    right(panel_width)
    {
        up(panel_bottom) small_rectangle(true, panel_pole_width);
        up(panel_middle) small_rectangle(true, panel_pole_width);
        up(panel_top) small_rectangle(true, panel_pole_width);
    }
}

module back_panel(is_male)
{
    module back_panel_main()
    {
        difference()
        {
            union()
            {
                size = [ panel_pole_thickness, panel_pole_width ];
                h = inner_half_width - pole_size / 2;
                up(panel_bottom) prismoid(size, size, rounding = panel_pole_rounding, h = h, orient = RIGHT);
                up(panel_middle) prismoid(size, size, rounding = panel_pole_rounding, h = panel_width, orient = RIGHT);
                up(panel_top) prismoid(size, size, rounding = panel_pole_rounding, h = panel_width, orient = RIGHT);

                up((panel_bottom + panel_top) / 2) right(panel_width / 4)
                {
                    total_height = panel_top - panel_bottom + panel_pole_thickness;
                    size1 = [ panel_pole_thickness, panel_pole_width, total_height ];
                    cuboid(size1, rounding = panel_pole_rounding);
                    right(panel_width / 2) cuboid(size1, rounding = panel_pole_rounding);
                }

                up(panel_middle) right(panel_width)
                {
                    size1 = [ panel_pole_width, panel_pole_width ];
                    h = inner_height - panel_middle - pole_size / 2;
                    prismoid(size1, size1, rounding = panel_pole_rounding, h = h);
                }

                up(inner_height - pole_size / 2) right(panel_width) yrot(90) small_rectangle(false, pole_size / 2);
                back_frames_base(panel_middle, panel_top, frame_rim - 1, frame_depth / 3, panel_pole_width);
                back_frames_base(panel_bottom, panel_middle, grate_rim, grate_depth, 0);
            }

            up(panel_middle) right(panel_width - get_slop() / 2) zcopies(panel_top - panel_middle, 2, sp = 0)
            {
                cuboid([ pole_size, pole_size, panel_pole_thickness + get_slop() ], anchor = LEFT);
            }

            side_holes();

            up((sign_bottom_bound + sign_top_bound) / 2) right(panel_width)
            {
                cuboid([ panel_pole_width + 1, sign_depth + get_slop(), sign_support_size + get_slop() ]);
            }
        }
    }

    mask_offset = panel_width / 4 + 0.5 + (is_male ? get_slop() : 0);

    module dovetail_panel()
    {
        slide = panel_top - panel_bottom - (is_male ? get_slop() * 2 : 0);
        up((panel_bottom + panel_top) / 2) right(mask_offset + (is_male ? 0 : get_slop())) xrot(90)
            yrot(is_male ? -90 : 90) dovetail_modified(is_male, slide);
    }

    mask = [ mask_offset, panel_pole_width + 1, inner_height ];

    if (is_male)
    {
        difference()
        {
            back_panel_main();
            cuboid(mask, anchor = BOTTOM + LEFT);
        }
        dovetail_panel();
    }
    else
    {
        difference()
        {
            intersection()
            {
                back_panel_main();
                cuboid(mask, anchor = BOTTOM + LEFT);
            }
            dovetail_panel();
        }
    }
}

module side_panels()
{
    module dovetail_panel()
    {
        right(panel_pole_width / 2 + get_slop()) fwd(inner_depth) yrot(90) dovetail_modified(false, 4);
    }

    difference()
    {
        right(panel_width)
        {
            size1 = [ panel_pole_width, panel_pole_thickness ];
            size2 = [ panel_pole_width / 2, panel_pole_width, panel_pole_thickness ];

            up(panel_middle)
            {
                difference()
                {
                    prismoid(size1, size1, rounding = panel_pole_rounding, h = panel_depth, orient = FORWARD);
                    cuboid([ pole_size, panel_pole_width + get_slop(), pole_size ], anchor = RIGHT);
                    dovetail_panel();
                }
                edges = [ FRONT + BOTTOM, RIGHT + FRONT, RIGHT + BACK, BOTTOM + BACK ];
                cuboid(size2, rounding = panel_pole_rounding, edges = edges, anchor = LEFT);
            }

            up(panel_top)
            {
                difference()
                {
                    prismoid(size1, size1, rounding = panel_pole_rounding, h = panel_depth, orient = FORWARD);
                    cuboid([ pole_size, panel_pole_width + get_slop(), pole_size ], anchor = RIGHT);
                    dovetail_panel();
                }
                edges = [ RIGHT + FRONT, RIGHT + BACK ];
                cuboid(size2, rounding = panel_pole_rounding, edges = edges, anchor = LEFT);
            }

            size3 = [ panel_pole_width, panel_pole_thickness, panel_top - panel_middle + panel_pole_thickness ];
            up((panel_middle + panel_top) / 2) fwd(panel_depth) cuboid(size3, rounding = panel_pole_rounding);
            side_frames_base(frame_rim - 1, frame_depth / 3);
        }

        side_holes();
    }
}

module back_frames_base(bottom_level, top_level, rim, depth, end_offset)
{
    up((bottom_level + top_level) / 2)
    {
        panel_height = top_level - bottom_level - panel_pole_thickness;
        size1 = [ panel_width / 2 - panel_pole_thickness, panel_height ];
        right_half(s = inner_height) rect_tube(size = size1, wall = rim, h = depth, anchor = CENTER, orient = FRONT);
        right(panel_width / 2) rect_tube(size = size1, wall = rim, h = depth, anchor = CENTER, orient = FRONT);
        end_width = panel_width / 4 - panel_pole_thickness / 2 - panel_pole_width / 2 + panel_pole_width - end_offset;
        size2 = [ end_width, panel_height ];
        right(inner_half_width - pole_size / 2 - end_offset)
            rect_tube(size = size2, wall = rim, h = depth, anchor = RIGHT, orient = FRONT);
    }
}

module back_frames()
{
    color_this("firebrick") difference()
    {
        back_frames_base(panel_middle, panel_top, frame_rim, frame_depth, panel_pole_width);
        cuboid([ inner_half_width, frame_depth / 3, inner_height ], anchor = BOTTOM + LEFT);
    }
}

module side_frames_base(rim, depth)
{
    total_depth = panel_depth - panel_pole_thickness / 2;
    up((panel_middle + panel_top) / 2) fwd(total_depth)
    {
        size = [ panel_top - panel_middle - panel_pole_thickness, total_depth - panel_pole_width / 2 - get_slop() / 2 ];
        rect_tube(size = size, wall = rim, h = depth, anchor = FRONT, orient = RIGHT);
    }
}

module side_frames()
{
    total_depth = panel_depth - panel_pole_thickness / 2;
    color_this("firebrick") right(panel_width) difference()
    {
        side_frames_base(frame_rim, frame_depth);
        cuboid([ frame_depth / 3, outer_depth, inner_height ], anchor = BOTTOM + BACK);
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
        cuboid([ sign_width + sign_support_size + panel_pole_width, sign_depth, sign_support_size ], anchor = LEFT);
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