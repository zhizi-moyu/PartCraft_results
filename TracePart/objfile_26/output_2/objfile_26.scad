
// Constants for dimensions
shaft_length = 130; // Adjust the shaft length to match the original
shaft_diameter = 10;

grooved_cyl_length = 25; // Ensure the length is consistent with the original
grooved_cyl_diameter = 12;
groove_depth = 3;  // Increase groove depth for better definition
groove_count = 6;  // Ensure proper count and spacing

notched_ring_thickness = 4; 
notched_ring_diameter = 16;
notch_width = 3;
notch_depth = 4;  // Increase the depth of the notches for better definition

bearing_interface_thickness = 4;  
bearing_diameter = 14;

// Functions to create components
module shaft() {
    union() {
        cylinder(h = shaft_length, d = shaft_diameter);

        translate([0, 0, shaft_length - 8]) {
            cylinder(h = 4, d = shaft_diameter + 3); // Fine-tune positions and dimensions
        }
        translate([0, 0, 5]) {
            cylinder(h = 4, d = shaft_diameter + 3);
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
        for(i = [0 : 360 : 360 / 8]) {  
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
        translate([0, 0, -1]) { // Enhance recess depth for bearing interface
            cylinder(h = 1, d = bearing_diameter - 3);
        }
    }
}

// Assemble model based on layers
module flexible_coupling() {
    translate([0, 0, shaft_length - bearing_interface_thickness]) {
        bearing_interface();
    }

    translate([0, 0, shaft_length - bearing_interface_thickness - notched_ring_thickness]) {
        notched_ring();
    }

    translate([0, 0, shaft_length - bearing_interface_thickness - notched_ring_thickness - grooved_cyl_length]) {
        grooved_cylinder();
    }

    shaft();

    translate([0, 0, grooved_cyl_length]) {
        grooved_cylinder();
    }

    translate([0, 0, grooved_cyl_length + notched_ring_thickness]) {
        notched_ring();
    }

    translate([0, 0, bearing_interface_thickness]) {
        bearing_interface();
    }
}

// Render the flexible coupling
flexible_coupling();

