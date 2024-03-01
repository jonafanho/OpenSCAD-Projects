include <constellations.scad>

points = [
    [ 0, 180, 116 ],
    [ 240, 0, 53 ],
];
connections = [
    [ 0, 1 ],
];
scale = [ 692, 69 ];

constellation(points, connections, scale);