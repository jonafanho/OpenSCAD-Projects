include <constellations.scad>

points = [
    [ 180, 239, 22 ],
    [ 0, 217, 30 ],
    [ 18, 52, 16 ],
    [ 153, 0, 18 ],
    [ 313, 50, 18 ],
    [ 222, 341, 19 ],
    [ 404, 446, 26 ],
    [ 658, 704, 20 ],
    [ 897, 629, 22 ],
    [ 1030, 703, 22 ],
    [ 1461, 681, 22 ],
    [ 1224, 982, 35 ],
    [ 721, 900, 23 ],
    [ 590, 1085, 19 ],
];
connections = [
    [ 0, 1, 2, 3, 4, 0, 5, 6, 7, 8, 9, 10, 11, 12, 7 ],
    [ 12, 13 ],
];
scale = [ 353, 36 ];

constellation(points, connections, scale, false, false);