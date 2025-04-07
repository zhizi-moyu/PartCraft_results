// Define dimensions
tabletop_length = 60;
tabletop_width = 40;
tabletop_thickness = 2;
leg_radius = 1;
leg_height = 30;
crossbar_radius = 0.5;
crossbar_length = tabletop_length - 2 * leg_radius;  // The length of the crossbar

// Module definitions
module tabletop() {
    // Single slab for tabletop
    translate([0, 0, leg_height])
        cube([tabletop_length, tabletop_width, tabletop_thickness], center = true);
}

module leg() {
    // Cylindrical legs
    cylinder(h = leg_height, r = leg_radius, center = false);
}

module crossbar(length) {
    // Cylindrical crossbars
    cylinder(h = length, r = crossbar_radius, center = false);
}

// Assemble the table
translate([-tabletop_length / 2, -tabletop_width / 2, 0]) {
    // Create the tabletop
    tabletop();
    
    // Create the legs
    rotate([90, 0, 0]) {
        translate([leg_radius, leg_radius, 0]) leg(); // Leg 1
        translate([tabletop_length - 2 * leg_radius, leg_radius, 0]) leg(); // Leg 2
        translate([leg_radius, tabletop_width - 2 * leg_radius, 0]) leg(); // Leg 3
        translate([tabletop_length - 2 * leg_radius, tabletop_width - 2 * leg_radius, 0]) leg(); // Leg 4
    }
    
    // Create the horizontal crossbars
    translate([leg_radius, tabletop_width / 2, leg_height / 2]) rotate([0, 90, 0]) crossbar(crossbar_length); // Crossbar along one side
    translate([tabletop_length / 2, leg_radius, leg_height / 2]) rotate([90, 0, 0]) crossbar(crossbar_length); // Crossbar along other side
}
