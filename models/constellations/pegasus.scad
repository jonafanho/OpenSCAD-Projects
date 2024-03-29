include <constellations.scad>

points = [
    [ 1282, 807, 31 ],
    [ 1061, 952, 22 ],
    [ 781, 789, 23 ],
    [ 581, 624, 31 ],
    [ 0, 569, 27 ],
    [ 106, 84, 35 ],
    [ 612, 170, 30 ],
    [ 1038, 0, 18 ],
    [ 779, 102, 26 ],
    [ 721, 301, 22 ],
    [ 750, 340, 19 ],
    [ 1068, 275, 20 ],
    [ 1248, 257, 18 ],
];
connections = [
    [ 0, 1, 2, 3, 4, 5, 6, 3 ],
    [ 7, 8, 6, 9, 10, 11, 12 ],
];
scale = [ 354, 35 ];

constellation(points, connections, scale);