include <../libraries/std.scad>

pixels = 16;
pattern = [
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], //
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], //
    [ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0 ], //
    [ 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0 ], //
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], //
    [ 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0 ], //
    [ 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0 ], //
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], //
    [ 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0 ], //
    [ 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0 ], //
    [ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], //
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0 ], //
    [ 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0 ], //
    [ 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0 ], //
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], //
    [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], //
];
assert(list_shape(pattern) == [ pixels, pixels ]);

module ore_pattern()
{
    for (row = [0:pixels - 1])
    {
        for (column = [0:pixels - 1])
        {
            if (pattern[row][column] > 0)
            {
                move([ row - pixels / 2, column - pixels / 2, -1 ]) cube(1);
            }
        }
    }
}
module ore_pattern_all()
{
    zrot_copies([ 0, 90, 180, 270 ]) right(pixels / 2) yrot(90) ore_pattern();
    yrot_copies([ 0, 180 ]) up(pixels / 2) ore_pattern();
}

difference()
{
    cube(pixels, anchor = CENTER);
    ore_pattern_all();
}