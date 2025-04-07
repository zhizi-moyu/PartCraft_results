// Constants for dimensions
shaft_length = 120; // Increased the length of the shaft
shaft_diameter = 10;

grooved_cyl_length = 25; // Adjusted length of grooved cylinder
grooved_cyl_diameter = 12;
groove_depth = 2;  // Enhanced depth of grooves
groove_count = 6;  // Increased groove count for better alignment

notched_ring_thickness = 4; // Decreased thickness slightly
notched_ring_diameter = 16;
notch_width = 3;  // Increased notch width
notch_depth = 3;  // Adjusted notch depth for better shape

bearing_interface_thickness = 4;  // Adjust thickness and alignment
bearing_diameter = 14;

// Functions to create components
module shaft() {
    union() {
        // Main cylindrical shaft
        cylinder(h = shaft_length, d = shaft_diameter);

        // Enhanced grooves at both ends
        translate([0, 0, shaft_length - 10]) {
            cylinder(h = 3, d = shaft_diameter + 2);
        }
        translate([0, 0, 7]) {
            cylinder(h = 3, d = shaft_diameter + 2);
        }
    }
}

module grooved_cylinder() {
    difference() {
        cylinder(h = grooved_cyl_length, d = grooved_cyl_diameter);
        for(i = [0 : groove_count - 1]) {
            translate([0, 0, i * (grooved_cyl_length / groove_count)]) {
                cylinder(h = groove_depth, d = grooved_cyl_diameter + 2);
            }
        }
    }
}

module notched_ring() {
    difference() {
        cylinder(h = notched_ring_thickness, d = notched_ring_diameter);
        for(i = [0 : 360 : 360 / 8]) {  // Adjusted notch distribution
            rotate([0, 0, i]) {
                translate([notched_ring_diameter / 2 - notch_width, 0, 0])
                    cube([notch_width, notch_depth, notched_ring_thickness]);
            }
        }
    }
}

module bearing_interface() {
    difference() {
        cylinder(h = bearing_interface_thickness, d = bearing_diameter);
        translate([0, 0, -0.5]) {
            cylinder(h = 0.5, d = bearing_diameter - 2); // Added subtle recess
        }
    }
}

// Assemble model based on layers
module flexible_coupling() {
    // Layer 1
    translate([0, 0, shaft_length - bearing_interface_thickness]) {
        bearing_interface();
    }

    // Layer 2
    translate([0, 0, shaft_length - bearing_interface_thickness - notched_ring_thickness]) {
        notched_ring();
    }

    translate([0, 0, shaft_length - bearing_interface_thickness - notched_ring_thickness - grooved_cyl_length]) {
        grooved_cylinder();
    }

    // Layer 3
    shaft();

    // Layer 4
    translate([0, 0, grooved_cyl_length]) {
        grooved_cylinder();
    }

    translate([0, 0, grooved_cyl_length + notched_ring_thickness]) {
        notched_ring();
    }

    // Layer 5
    translate([0, 0, bearing_interface_thickness]) {
        bearing_interface();
    }
}

// Render the flexible coupling
flexible_coupling();
