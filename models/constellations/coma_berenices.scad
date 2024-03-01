include <constellations.scad>

points = [
    [ 13, 571, 26 ],
    [ 0, 30, 26 ],
    [ 520, 0, 26 ],
];
connections = [
    [ 0, 1, 2 ],
];
scale = [ 523, 52 ];

constellation(points, connections, scale);