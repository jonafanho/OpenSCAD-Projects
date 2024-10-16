include <../../libraries/std.scad>
include <connector.scad>
include <constants.scad>

module poles()
{
    right(inner_half_width) difference()
    {
        h = inner_height - legs_height - pole_size / 2 + get_connector_thickness();
        up(legs_height) prismoid(pole_size, pole_size, rounding = pole_rounding, h = h);
        up(legs_height) zflip() zrot(90) female_connector();
        up(inner_height - pole_size / 2) zrot(90) male_connector([ pole_size, pole_size ]);
    }
}

module back_poles()
{
    poles();
    right(inner_half_width - pole_size / 2 - panel_pole_width / 2)
    {
        up(panel_bottom) small_rectangle(false, panel_pole_width);
        up(panel_middle) small_rectangle(false, panel_pole_width);
        up(panel_top) small_rectangle(false, panel_pole_width);
    }
}

module front_poles()
{
    module pole_dovetail()
    {
        yrot(-90) dovetail_modified(true, 4);
    }

    fwd(inner_depth)
    {
        poles();
        right(inner_half_width - pole_size / 2)
        {
            up(panel_middle) pole_dovetail();
            up(panel_top) pole_dovetail();
        }
    }
}