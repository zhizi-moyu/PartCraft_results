
// Parameters for key component dimensions
key_length = 30;  // Total length of the key
key_width = 12;   // Width of the key
key_thickness = 5; // Thickness of the key
rounded_edge_diameter = 6; // Diameter for rounded features

module key() {
    difference() {
        // Create the base shape of the key
        cube([key_length, key_width, key_thickness], center = true);
        
        // Add rounded edge cutouts at both ends
        translate([key_length / 2 - rounded_edge_diameter / 2, 0, 0])
            rotate([0, 90, 0])
            cylinder(d = rounded_edge_diameter, h = key_thickness, center = true);
        translate([-key_length / 2 + rounded_edge_diameter / 2, 0, 0])
            rotate([0, 90, 0])
            cylinder(d = rounded_edge_diameter, h = key_thickness, center = true);
    }
}

// Render the key component
key();

