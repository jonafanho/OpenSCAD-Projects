include <../constellations.scad>

layer = 0;

points1 = [
    [ 839, 0, 40 ],
    [ 1381, 1033, 44 ],
    [ 1499, 1222, 37 ],
    [ 1245, 1447, 37 ],
    [ 1088, 1351, 29 ],
    [ 856, 1410, 45 ],
    [ 673, 1446, 42 ],
    [ 479, 1646, 42 ],
];
points2 = [
    points1[7],
    [ 0, 2844, 77 ],
];
points3 = [
    points2[1],
    [ 540, 4225, 57 ],
];
points4 = [
    points3[1],
    [ 1154, 4481, 32 ],
    [ 1302, 4540, 36 ],
    [ 1333, 4764, 32 ],
    [ 1077, 4765, 36 ],
    [ 972, 6183, 48 ],
    [ 1245, 4450, 1 ],
];
points5 = [
    points4[5],
    [ 963, 6429, 66 ],
    [ 1063, 6270, 34 ],
    [ 868, 6283, 53 ],
    [ 445, 6338, 66 ],
    [ 249, 6394, 88 ],
];
connections1 = [
    [ 0, 1, 2, 3, 4 ],
    [ 1, 4, 5, 6, 7 ],
];
connections2 = [
    [ 0, 1 ],
];
connections3 = [
    [ 0, 1 ],
];
connections4 = [
    [ 0, 1, 2, 3, 4, 1 ],
    [ 5, 6 ],
];
connections5 = [
    [ 0, 1 ],
    [ 2, 3, 4, 5 ],
];
scale = [ 423, 42 ];

if (layer == 0)
{
    constellation(points1, connections1, scale, [[points2 [1], points2 [0]]], []);
}
else if (layer == 1)
{
    constellation(points2, connections2, scale, [], [[points2 [1], points2 [0]], [points2 [0], points2 [1]]]);
}
else if (layer == 2)
{
    constellation(points3, connections3, scale, [[points2 [0], points2 [1]], [points4 [1], points4 [0]]], []);
}
else if (layer == 3)
{
    constellation(points4, connections4, scale, [], [[points4 [1], points4 [0]], [points4 [6], points4 [5]]]);
}
else if (layer == 4)
{
    constellation(points5, connections5, scale, [[points4 [6], points4 [5]]], []);
}