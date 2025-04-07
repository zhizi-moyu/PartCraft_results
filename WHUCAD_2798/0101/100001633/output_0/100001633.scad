
// Define dimensions
tabletop_length = 60;
tabletop_width = 40;
tabletop_thickness = 2;
leg_radius = 1;
leg_height = 30;
crossbar_radius = 0.5;
crossbar_height = tabletop_length - 2 * leg_radius;  // The length of the crossbar

// Module definitions
module tabletop() {
    translate([0, 0, leg_height])
        cube([tabletop_length, tabletop_width, tabletop_thickness], center = true);
}

module leg() {
    cylinder(h = leg_height, r = leg_radius, center = false);
}

module crossbar() {
    cylinder(h = crossbar_height, r = crossbar_radius, center = false);
}

// Assemble the table
translate([-tabletop_length/2, -tabletop_width/2, 0]) {
    // Create the tabletop
    tabletop();
    
    // Create the legs
    translate([leg_radius, leg_radius, 0]) rotate([90, 0, 0]) leg(); // Leg 1
    translate([tabletop_length - leg_radius, leg_radius, 0]) rotate([90, 0, 0]) leg(); // Leg 2
    translate([leg_radius, tabletop_width - leg_radius, 0]) rotate([90, 0, 0]) leg(); // Leg 3
    translate([tabletop_length - leg_radius, tabletop_width - leg_radius, 0]) rotate([90, 0, 0]) leg(); // Leg 4

    // Create the horizontal crossbars
    translate([leg_radius, leg_radius, leg_height/2]) rotate([0, 90, 0]) crossbar(); // Crossbar 1
    translate([tabletop_length - leg_radius, leg_radius, leg_height/2]) rotate([0, 90, 0]) crossbar(); // Crossbar 2
}

