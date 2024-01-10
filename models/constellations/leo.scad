include <constellations.scad>

points = [
    [ 1260, 89, 32 ],
    [ 1191, 0, 25 ],
    [ 954, 115, 27 ],
    [ 915, 260, 42 ],
    [ 1055, 396, 27 ],
    [ 1037, 588, 52 ],
    [ 367, 452, 28 ],
    [ 0, 468, 41 ],
    [ 370, 232, 35 ],
];
connections = [
    [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 3 ],
];
scale = [ 426, 43 ];

constellation(points, connections, scale);