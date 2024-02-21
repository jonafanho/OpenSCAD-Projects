include <constellations.scad>

points = [
    [ 207, 137, 36 ],
    [ 130, 427, 44 ],
    [ 0, 471, 46 ],
    [ 74, 187, 34 ],
    [ 265, 6, 130 ],
    [ 213, 0, 32 ],
];
connections = [
    [ 0, 1, 2, 3, 0, 4, 5, 0 ],
];
scale = [ 691, 69 ];

constellation(points, connections, scale);