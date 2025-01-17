include <../../openscad/libraries/rounding.scad>
include <../../openscad/libraries/std.scad>

// 1. Download the full size constellation image from https://www.iau.org/public/themes/constellations
// 2. Get the x, y, and width of each star
// 3. Normalize all x y coordinates
// 4. Get the height of 10 degrees on the map and the width of the "2" star in the legend

star_height = 2;
bar_height = 1;
bar_width = 2;
bar_width_small = 2 / 3;
point_scale = 60;
star_scale = 0.8;

raised = true;
$fn = $preview ? 16 : 64;

module star(corners, size, offset)
{
    path = round_corners(path = star(n = corners, r = 10 * size, ir = 5 * size), r = size);
    linear_extrude(star_height) polygon(offset == 0 ? path : offset(path, delta = offset));
}

module constellation(points, connections, scale, female_joints = [], male_joints = [])
{
    scale1 = point_scale / scale[0];
    scale2 = star_scale / scale[1];
    joint_padding = 0.2;
    joint_diameter = bar_width * 1.5;

    module single_star(point, offset)
    {
        right(point[0] * scale1) fwd(point[1] * scale1) star(5, point[2] * scale2, offset);
    }

    module stars(offset)
    {
        for (point = points)
        {
            single_star(point, offset);
        }
    }

    module connections(width, height)
    {
        for (group = connections)
        {
            path = [for (connection = group)[points[connection][0] * scale1, -points[connection][1] * scale1]];
            path_extrude2d(path) square([ width, height ], anchor = BOTTOM);
        }
    }

    module joint_hole(joint_pair, inner)
    {
        point1 = joint_pair[0];
        point2 = joint_pair[1];
        joint_padding1 = inner ? -joint_padding : 0;
        joint_padding2 = inner ? 0 : joint_padding;
        right(point2[0] * scale1) fwd(point2[1] * scale1)
            cyl(bar_height + joint_padding1, d = joint_diameter + joint_padding2, anchor = BOTTOM);
        path_extrude2d([
            [ point1[0] * scale1, -point1[1] * scale1 ],
            [ point2[0] * scale1, -point2[1] * scale1 ],
        ]) square([ bar_width + joint_padding2, bar_height + joint_padding1 ], anchor = BOTTOM);
    }

    difference()
    {
        union()
        {
            stars(0);
            connections(bar_width, bar_height);

            if (raised)
            {
                difference()
                {
                    connections(bar_width_small, star_height);
                    stars(bar_width / 3);
                }
            }
        }

        for (female_joint = female_joints)
        {
            joint_hole(female_joint, 0);
        }

        for (male_joint = male_joints)
        {
            single_star(male_joint[1], joint_padding);
        }
    }

    for (male_joint = male_joints)
    {
        intersection()
        {
            single_star(male_joint[1], joint_padding);
            joint_hole(male_joint, joint_padding);
        }
    }
}