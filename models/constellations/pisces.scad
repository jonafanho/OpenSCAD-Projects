include <constellations.scad>

points = [
    [ 493, 0, 17 ],
    [ 426, 98, 16 ],
    [ 469, 195, 16 ],
    [ 301, 511, 22 ],
    [ 168, 724, 18 ],
    [ 0, 936, 21 ],
    [ 194, 857, 17 ],
    [ 296, 841, 15 ],
    [ 539, 788, 18 ],
    [ 665, 802, 17 ],
    [ 1101, 822, 19 ],
    [ 1275, 857, 19 ],
    [ 1380, 824, 19 ],
    [ 1483, 925, 22 ],
    [ 1404, 1007, 15 ],
    [ 1265, 996, 17 ],
];
connections = [
    [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 11 ],
];
scale = [ 354, 36 ];

constellation(points, connections, scale);