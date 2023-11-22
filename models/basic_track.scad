include <connector.scad>

track_lengths = [ 50, 100, 150, 200 ];

xcopies(track_radius * 4, n = len(track_lengths))
{
    track_offset = track_lengths[$idx];
    connector();
    back(track_offset) yflip() connector();
    back(connector_length) track(track_offset - connector_length * 2);
}