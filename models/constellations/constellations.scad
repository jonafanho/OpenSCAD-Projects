include <../libraries/rounding.scad>
include <../libraries/std.scad>

// 1. Download the full size constellation image from https://www.iau.org/public/themes/constellations
// 2. Get the x, y, and width of each star
// 3. Normalize all x y coordinates
// 4. Get the height of 10 degrees on the map and the width of the "2" star in the legend

star_height = 2;
bar_height = 1;
bar_width = 2;
point_scale = 60;
star_scale = 0.8;

raised = true;

module star(corners, size, offset)
{
    path = round_corners(path = star(n = corners, r = 10 * size, ir = 5 * size), r = size);
    linear_extrude(star_height) polygon(offset == 0 ? path : offset(path, delta = offset));
}

module constellation(points, connections, scale)
{
    scale1 = point_scale / scale[0];
    scale2 = star_scale / scale[1];

    module stars(offset)
    {
        for (point = points)
        {
            right(point[0] * scale1) fwd(point[1] * scale1) star(5, point[2] * scale2, offset);
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

    stars(0);
    connections(bar_width, bar_height);

    if (raised)
    {
        difference()
        {
            connections(bar_width / 3, star_height);
            stars(bar_width / 3);
        }
    }
}