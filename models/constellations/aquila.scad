include <constellations.scad>

points = [
    [ 213, 453, 31 ],
    [ 251, 304, 73 ],
    [ 326, 228, 42 ],
    [ 601, 624, 35 ],
    [ 855, 1043, 34 ],
    [ 459, 859, 26 ],
    [ 0, 829, 36 ],
    [ 250, 737, 30 ],
    [ 859, 58, 39 ],
    [ 939, 0, 28 ],
];
connections = [
    [ 0, 1, 2, 3, 4, 5, 6, 7, 3, 8, 4 ],
    [ 8, 9 ],
];
scale = [ 524, 52 ];

constellation(points, connections, scale);