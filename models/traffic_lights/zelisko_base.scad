include <../../openscad/libraries/rounding.scad>
include <../../openscad/libraries/std.scad>

base_height = 23;
rounding_radius = 8;
sweep_rounding = os_circle(rounding_radius);
sweep_fn = $fn == 0 ? 16 : $fn / 4;

function length(large) = large ? 252 : 184;
function width(large) = large ? 350 : 269;
function height(large) = large ? 355 : 284;

module conditional_cut(intersect)
{
    if (intersect)
    {
        intersection()
        {
            children(0);
            children(1);
        }
    }
    else
    {
        difference()
        {
            children(0);
            children(1);
        }
    }
}