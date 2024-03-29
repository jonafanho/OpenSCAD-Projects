include <constellations.scad>

points = [
    [ 273, 43, 24 ],   [ 124, 397, 23 ],  [ 395, 410, 22 ],  [ 463, 419, 29 ], [ 1106, 125, 19 ],
    [ 964, 45, 21 ],   [ 873, 0, 23 ],    [ 783, 172, 21 ],  [ 724, 320, 26 ], [ 0, 737, 23 ],
    [ 89, 723, 25 ],   [ 186, 790, 27 ],  [ 331, 864, 20 ],  [ 473, 911, 29 ], [ 601, 659, 23 ],
    [ 993, 1323, 19 ], [ 999, 1108, 24 ], [ 904, 1018, 33 ], [ 761, 615, 33 ],
];
connections = [
    [ 0, 1, 2, 3, 8 ],
    [ 4, 5, 6, 7, 8, 18 ],
    [ 9, 10, 11, 12, 13, 14, 3 ],
    [ 15, 16, 17, 18, 14 ],
];
scale = [ 411, 41 ];

constellation(points, connections, scale);