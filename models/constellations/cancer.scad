include <constellations.scad>

points = [
    [ 174, 0, 30 ],
    [ 206, 382, 24 ],
    [ 185, 554, 29 ],
    [ 0, 878, 26 ],
    [ 410, 844, 19 ],
    [ 545, 1024, 33 ],
];
connections = [
    [ 0, 1, 2, 3 ],
    [ 2, 4, 5 ],
];
scale = [ 523, 52 ];

constellation(points, connections, scale);