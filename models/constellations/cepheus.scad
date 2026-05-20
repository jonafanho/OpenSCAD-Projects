include <constellations.scad>

points = [
    [ 710, 478, 21 ],
    [ 661, 553, 27 ],
    [ 492, 583, 35 ],
    [ 412, 773, 22 ],
    [ 260, 816, 27 ],
    [ 243, 868, 22 ],
    [ 157, 813, 25 ],
    [ 68, 490, 26 ],
    [ 0, 0, 28 ],
    [ 362, 285, 28 ],
];
connections = [
    [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 2 ],
    [ 7, 9 ],
];
scale = [ 410, 41 ];

constellation(points, connections, scale);