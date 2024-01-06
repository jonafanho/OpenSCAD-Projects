include <constellations.scad>

points = [
    [ 1289, 362, 21 ],
    [ 910, 203, 27 ],
    [ 608, 11, 27 ],
    [ 465, 48, 20 ],
    [ 400, 0, 22 ],
    [ 341, 5, 19 ],
    [ 0, 226, 18 ],
    [ 194, 273, 21 ],
    [ 226, 486, 19 ],
    [ 184, 566, 24 ],
    [ 509, 275, 19 ],
    [ 599, 492, 19 ],
];
connections = [
    [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ],
    [ 2, 10, 11 ],
];
scale = [ 355, 36 ];

constellation(points, connections, scale, false, false);