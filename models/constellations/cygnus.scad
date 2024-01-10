include <constellations.scad>

points = [
    [ 308, 381, 52 ],
    [ 463, 602, 39 ],
    [ 704, 815, 24 ],
    [ 978, 1077, 32 ],
    [ 0, 1007, 30 ],
    [ 256, 868, 36 ],
    [ 740, 375, 33 ],
    [ 805, 85, 24 ],
    [ 871, 0, 25 ],
];
connections = [
    [ 0, 1, 2, 3 ],
    [ 4, 5, 1, 6, 7, 8 ],
];
scale = [ 425, 43 ];

constellation(points, connections, scale);