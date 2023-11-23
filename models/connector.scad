include <base.scad>

connector_length = 10;

module connector()
{
    connector_curvature = 10;
    connector_size = 3;
    connector_padding = 0.2;
    sphere_offset_y = 3.5;
    sphere_offset_z = 10;

    module slicer()
    {
        ymove(connector_padding / 2) zflip() linear_extrude(track_radius + track_thickness)
        {
            rect([ (track_radius + track_thickness) * 2, connector_length + connector_padding ], anchor = BACK);
        }
    }

    module connector_piece(padding, flip)
    {
        yflip_copy() down(connector_size + 2) yrot(flip ? 90 : -90) linear_extrude(track_radius + track_thickness)
        {
            path = left(connector_curvature - connector_size / 2, p = arc(angle = 30, r = connector_curvature));
            stroke(path, width = connector_size - padding, $fn = $fn / 5);
        }
    }

    module small_sphere(padding)
    {
        spheroid(r = 1 + padding, style = "icosa", $fn = $fn / 5);
    }

    difference()
    {
        yflip_copy() track(connector_length);
        slicer();
        connector_piece(0, false);
        connector_piece(0, true);
        down(sphere_offset_z) left(sphere_offset_y) fwd(1 - connector_padding * 2) small_sphere(connector_padding);
    }

    down(sphere_offset_z) right(sphere_offset_y) back(1 - connector_padding * 2) small_sphere(0);

    intersection()
    {
        yflip_copy() track(connector_length);
        slicer();
        xflip() union()
        {
            connector_piece(connector_padding, false);
            connector_piece(connector_padding, true);
        }
    }
}