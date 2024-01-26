include <avalon.scad>
include <quest_token.scad>
include <vote_token.scad>

layer = 0;
variation = 0;

player_info = [
    // player count, good guys, quest player counts, 2 fails required on 4th round
    [ 5, 3, [ 2, 3, 2, 3, 3 ], false ],
    [ 6, 4, [ 2, 3, 4, 3, 4 ], false ],
    [ 7, 4, [ 2, 3, 3, 4, 4 ], true ],
    [ 8, 5, [ 3, 4, 4, 5, 5 ], true ],
    [ 9, 6, [ 3, 4, 4, 5, 5 ], true ],
    [ 10, 6, [ 3, 4, 4, 5, 5 ], true ],
];

module box_half(height)
{
    rounding = 4;
    x = 160;
    y = 80;

    difference()
    {
        cuboid([ x, y, height ], rounding = rounding, except = TOP, anchor = TOP);
        up(1) cuboid([ x - 2, y - 2, height - 2 ], rounding = rounding - 1, except = TOP, anchor = TOP);
    }
}

module box_bottom()
{
    box_half(30);
}

module box_top()
{
    height = 10;

    zflip() box_half(height);
}

module top_shape()
{
    quest_spacing = 40;
    x = quest_spacing * 5;
    y = quest_spacing + 50;
    text_padding = 6;
    left_text = text_padding - x / 2;
    top_text = text_padding - y / 2;

    module text_objects(thickness)
    {
        player_count = player_info[variation][0];
        player_count_blue = player_info[variation][1];
        quest_counts = player_info[variation][2];

        draw_text(str(player_count, " Players"), left_text, top_text + 5, 6, LEFT + BACK, thickness);
        draw_text(str(player_count_blue, "x "), -left_text - 6, top_text + 2, 6, RIGHT + BACK, thickness);
        draw_text(str(player_count - player_count_blue, "x "), -left_text - 6, top_text + 10, 6, RIGHT + BACK,
                  thickness);

        if (player_info[variation][3])
        {
            right(quest_spacing) fwd(10) zrot(36)
            {
                back(20) draw_text("2 Fails", 0, 0, 4, FWD, thickness);
                back(14) draw_text("Required", 0, 0, 4, FWD, thickness);
            }
        }

        for (i = [0:4])
        {
            draw_text(str(quest_counts[i]), quest_spacing * (i - 2), -top_text, 12, FWD, thickness);
        }
    }

    module icon(top_offset)
    {
        left(left_text) fwd(top_text + top_offset) scale([ 0.3, 0.3, 1 ]) left(10) zrot(90) linear_extrude(1)
            children();
    }

    module icon_holes()
    {
        down(0.2) zscale(0.2)
        {
            icon(5) circle(r = 10);
            icon(13) circle(r = 10);
        }
    }

    if (layer == 0)
    {
        difference()
        {
            down(2) linear_extrude(2) rect([ x, y ], rounding = 1);
            xcopies(quest_spacing, 5) fwd(10) zrot(90) down(1) linear_extrude(2) quest_token_base(0.4);
            xcopies(quest_spacing / 2, 5) fwd(top_text + 9) down(1) linear_extrude(2) vote_token_base(0.4);
            down(0.2) linear_extrude(1) text_objects(1);
            icon_holes();
        }
    }
    else if (layer == 1)
    {
        down(0.2) linear_extrude(0.2) text_objects(1);
        icon_holes();
    }
    else if (layer == 2)
    {
        linear_extrude(1) text_objects(0);
        icon(5) blue_shape();
        icon(13) red_shape();
        xcopies(quest_spacing, 5) fwd(10) zrot(90) difference()
        {
            linear_extrude(1) quest_token_base(1.4);
            down(1) linear_extrude(3) quest_token_base(0.4);
        }
        xcopies(quest_spacing / 2, 5) fwd(top_text + 9) difference(){
            linear_extrude(1) vote_token_base(1.4);
            down(1) linear_extrude(3) vote_token_base(0.4);
        }
    }
}

// box_bottom();
// box_top();
top_shape();