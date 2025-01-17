include <../../openscad/libraries/std.scad>

$fn = 50;
track_radius = 9;
track_thickness = 3;

module track(length)
{
    xrot(-90) linear_extrude(length) difference()
    {
        arc(angle = 180, r = track_radius + track_thickness);
        arc(angle = 180, r = track_radius);
    }
}