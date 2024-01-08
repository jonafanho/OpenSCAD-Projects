include <constellations.scad>

points = [
    [ 0, 0, 35 ],
    [ 143, 201, 43 ],
    [ 330, 182, 46 ],
    [ 449, 395, 49 ],
    [ 648, 230, 48 ],
];
connections = [
    [ 0, 1, 2, 3, 4 ],
];
scale = [ 525, 52 ];

constellation(points, connections, scale, false, false);