include <constellations.scad>

points = [
    [ 750, 705, 48 ],
    [ 484, 944, 35 ],
    [ 391, 557, 34 ],
    [ 260, 374, 41 ],
    [ 0, 258, 33 ],
    [ 391, 116, 33 ],
    [ 70, 0, 29 ],
    [ 616, 475, 42 ],
    [ 398, 344, 36 ],
];
connections = [
    [ 0, 1, 2, 3, 4, 5, 6, 4, 1 ],
    [ 7, 8, 3 ],
];
scale = [ 524, 53 ];

constellation(points, connections, scale, false, false);