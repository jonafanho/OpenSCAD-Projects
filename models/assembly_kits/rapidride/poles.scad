include <../../libraries/std.scad>
include <constants.scad>

module back_poles()
{
    right(inner_half_width) up(legs_height)
    {
        prismoid(pole_size, pole_size, rounding = pole_rounding, h = inner_height - legs_height);
    }
}

module front_poles()
{
    right(inner_half_width) up(legs_height)
    {
        fwd(inner_depth) prismoid(pole_size, pole_size, rounding = pole_rounding, h = inner_height - legs_height);
    }
}