
// Parameters
l_bracket_length = 60; // Length of the L-bracket base
l_bracket_width = 60;  // Width of the L-bracket base
l_bracket_height = 30; // Height of the vertical section
thickness = 8;         // Increased thickness for better structure
hole_diameter = 12;    // Increased diameter of the central hole
mounting_hole_diameter = 5; // Diameter of the smaller mounting holes
mounting_hole_offset = 12;  // Adjusted distance from the edges to the mounting holes

// Function to create a hole
module create_hole(diameter, depth) {
    translate([0, 0, -0.1]) // Slightly offset to ensure through cut
        cylinder(d=diameter, h=depth + 0.2, center=true);
}

// Main L-bracket
module l_bracket() {
    // Base section
    difference() {
        cube([l_bracket_length, l_bracket_width, thickness], center=false);
        // Central hole (aligned and enlarged)
        translate([l_bracket_length / 2, l_bracket_width / 2, thickness / 2])
            create_hole(hole_diameter, thickness);
        // Mounting holes (symmetrical placement)
        for (x = [-1, 1])
            for (y = [-1, 1])
                translate([
                    l_bracket_length / 2 + x * (l_bracket_length / 2 - mounting_hole_offset),
                    l_bracket_width / 2 + y * (l_bracket_width / 2 - mounting_hole_offset),
                    thickness / 2
                ])
                    create_hole(mounting_hole_diameter, thickness);
    }

    // Vertical section
    translate([0, 0, thickness]) {
        difference() {
            cube([thickness, l_bracket_width, l_bracket_height], center=false);
            // Mounting holes on the vertical section (aligned and symmetrical)
            for (y = [-1, 1])
                translate([
                    thickness / 2,
                    l_bracket_width / 2 + y * (l_bracket_width / 2 - mounting_hole_offset),
                    l_bracket_height / 2
                ])
                    rotate([90, 0, 0])
                        create_hole(mounting_hole_diameter, l_bracket_height);
        }
    }
}

// Render the L-bracket
l_bracket();

