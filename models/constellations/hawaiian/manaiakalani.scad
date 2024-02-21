include <../constellations.scad>

points1 = [
    [ 1280, 244, 97 ],
    [ 120, 0, 63 ],
    [ 0, 568, 43 ],
    [ 277, 279, 48 ],
    [ 632, 46, 39 ],
    [ 827, 903, 39 ],
    [ 585, 1883, 73 ],
];
points2 = [
    points1[6],
    [ 2325, 4300, 59 ],
];
points3 = [
    points2[1],
    [ 2233, 4402, 47 ],
    [ 2182, 4462, 39 ],
    [ 2272, 4609, 56 ],
    [ 2532, 4650, 36 ],
    [ 2713, 4627, 33 ],
    [ 2769, 4403, 39 ],
    [ 2811, 4205, 49 ],
    [ 3025, 3920, 41 ],
    [ 3100, 3825, 73 ],
    [ 3220, 3818, 40 ],
    [ 3496, 3718, 48 ],
    [ 3472, 3560, 46 ],
    [ 3472, 3904, 40 ],
];
connections1 = [
    [ 1, 6, 0, 1, 3, 4 ],
    [ 2, 3, 5 ],
];
connections2 = [
    [ 0, 1 ],
];
connections3 = [
    [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ],
    [ 12, 11, 13 ],
];
scale = [ 524, 52 ];

constellation(points1, connections1, scale, [[points2 [1], points2 [0]]], []);
constellation(points2, connections2, scale, [], [[points2 [0], points2 [1]], [points2 [1], points2 [0]]]);
constellation(points3, connections3, scale, [[points2 [0], points2 [1]]], []);