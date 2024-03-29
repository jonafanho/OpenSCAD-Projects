include <constellations.scad>

points = [
    [ 0, 393, 25 ],
    [ 474, 405, 21 ],
    [ 757, 491, 28 ],
    [ 1312, 523, 38 ],
    [ 1550, 498, 24 ],
    [ 1859, 398, 26 ],
    [ 1914, 199, 23 ],
    [ 1710, 103, 23 ],
    [ 1099, 0, 32 ],
    [ 1171, 322, 28 ],
    [ 1021, 703, 21 ],
    [ 843, 923, 57 ],
    [ 38, 712, 24 ],
    [ 324, 724, 23 ],
];
connections = [
    [ 0, 1, 2, 3, 4, 5, 6, 7, 4 ],
    [ 8, 9, 3, 10, 11 ],
    [ 12, 13, 2 ],
];
scale = [ 423, 42 ];

constellation(points, connections, scale);