
// Parameters for key component dimensions
key_length = 30;  // Total length of the key
key_width = 12;   // Width of the key
key_thickness = 3; // Reduced thickness of the key
sharp_edge_cut = 0.5; // Cutting depth for sharper edges
key_alignment_offset = -1; // Adjustment for perfect alignment

module key() {
    difference() {
        // Create the base shape of the key with sharp edges
        resize([key_length, key_width, key_thickness]) 
            cube([key_length, key_width, key_thickness], center = true);

        // Refine edges by cutting small corners for sharpness
        translate([-key_length / 2 + sharp_edge_cut, 0, key_thickness / 2])
            cube([sharp_edge_cut * 2, key_width, key_thickness], center = true);

        // Adjust position for proper alignment
        translate([0, 0, key_alignment_offset])
            square([key_width - 2, 2], center = true);
    }
}

// Render the key
translate([0, 0, 0]) key();

