
// Define dimensions
cylinder_diameter = 20;
cylinder_height = 25;                      // Adjusted height to better match original model
hole_diameter = 5;
groove_width = 2.5;                        // Enhanced groove dimensions for better detailing
groove_depth = 6;                          // Adjusted groove depth for more pronounced look
spacer_thickness = 1.5;                    // Adjusted spacer thickness for proper spacing
locking_groove_depth = 3;                  // New variable for locking groove mechanism
locking_groove_width = 1.5;
locking_groove_position = 7;               // Position of locking grooves from the base

// Cylinder Body
module cylinder_body() {
    difference() {
        // Main cylindrical body with central hole
        cylinder(d=cylinder_diameter, h=cylinder_height, $fn=100);
        cylinder(d=hole_diameter, h=cylinder_height, $fn=100);
        
        // Adding alignment grooves
        for (i = [-120, 0, 120]) {
            rotate([0, 0, i]) {
                translate([cylinder_diameter/2 - groove_depth/2, -groove_width/2, cylinder_height / 2]) {
                    cube([groove_depth, groove_width, cylinder_height], center=false);
                }
            }
        }

        // Adding locking grooves on the top part of the cylindrical body
        for (i = [-120, 0, 120]) {
            rotate([0, 0, i]) {
                translate([cylinder_diameter/2 - locking_groove_depth/2, -locking_groove_width/2, locking_groove_position]) {
                    cube([locking_groove_depth, locking_groove_width, cylinder_height/3], center=false);
                }
            }
        }
    }
}

// Internal Spacer
module internal_spacer() {
    difference() {
        // Thin disk-like spacer
        cylinder(d=cylinder_diameter, h=spacer_thickness, $fn=100);
        cylinder(d=hole_diameter, h=spacer_thickness, $fn=100);
    }
}

// Assembly
module assembly() {
    translate([0, 0, 0]) {                  // Lower cylinder
        cylinder_body();
    }
    translate([0, 0, (cylinder_height - spacer_thickness) / 2]) {   // Spacer in the middle
        internal_spacer();
    }
    translate([0, 0, cylinder_height + spacer_thickness]) {         // Upper cylinder
        cylinder_body();
    }
}

// Main Module
assembly();

