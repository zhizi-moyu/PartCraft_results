
// Parameters for the table components
tabletop_length = 90; // Adjusted to better match the original model proportions
tabletop_width = 50;  // Adjusted to better match the original model proportions
tabletop_thickness = 2;

leg_diameter = 2;
leg_height = 40;

support_beam_length = 80;
support_beam_width = 2;
support_beam_height = 2;

// Tabletop
module tabletop() {
    translate([0, 0, leg_height])
        cube([tabletop_length, tabletop_width, tabletop_thickness]);
}

// Leg
module leg() {
    cylinder(h = leg_height, d = leg_diameter);
}

// Support Beam
module support_beam() {
    cube([support_beam_length, support_beam_width, support_beam_height]);
}

// Assemble the table
module table() {
    // Layer 1: Tabletop
    tabletop();

    // Layer 2: Support Beams
    translate([5, tabletop_width/2 - support_beam_width/2, leg_height - support_beam_height])
        support_beam();
    translate([5, -tabletop_width/2 + support_beam_width/2, leg_height - support_beam_height])
        support_beam();

    // Layer 3: Legs
    translate([0, 0, 0])
        leg();
    translate([tabletop_length - leg_diameter, 0, 0])
        leg();
    translate([0, tabletop_width - leg_diameter, 0])
        leg();
    translate([tabletop_length - leg_diameter, tabletop_width - leg_diameter, 0])
        leg();
}

// Render the table
table();

