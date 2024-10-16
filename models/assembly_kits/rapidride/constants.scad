model_scale = 13; // 1:13 scale
function dimension_scale(dimension_inches) = dimension_inches * 25.4 / model_scale;

inner_height = dimension_scale(108);
inner_half_width = dimension_scale(73);
outer_half_width = dimension_scale(109);
inner_depth = dimension_scale(19);
outer_depth = dimension_scale(67);

pole_size = dimension_scale(4);
pole_rounding = dimension_scale(0.25);

legs_height = dimension_scale(7);

panel_pole_width = dimension_scale(3);
panel_pole_thickness = dimension_scale(2);
panel_pole_rounding = dimension_scale(0.25);
panel_bottom = dimension_scale(17);
panel_middle = dimension_scale(29);
panel_top = dimension_scale(85);

front_sign_overhang = dimension_scale(8);
front_sign_height = dimension_scale(10);