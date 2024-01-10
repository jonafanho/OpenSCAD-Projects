include <constellations.scad>

points = [
    [ 745, 0, 38 ],
    [ 616, 109, 25 ],
    [ 517, 198, 23 ],
    [ 553, 479, 56 ],
    [ 248, 474, 50 ],
    [ 0, 420, 29 ],
    [ 23, 327, 27 ],
    [ 375, 318, 28 ],
    [ 217, 717, 33 ],
    [ 126, 802, 28 ],
];
connections = [
    [ 0, 1, 2, 3, 4, 5, 6, 7, 3 ],
    [ 4, 8, 9 ],
];
scale = [ 524, 52 ];

constellation(points, connections, scale);