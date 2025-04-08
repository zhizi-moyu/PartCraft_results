
// Parameters
l_bracket_length = 60; // Length of the L-bracket base
l_bracket_width = 60;  // Width of the L-bracket base
l_bracket_height = 30; // Height of the vertical section
thickness = 8;         // Thickness of the bracket
hole_diameter = 20;    // Enlarged diameter of the central hole
mounting_hole_diameter = 5; // Diameter of the smaller mounting holes
mounting_hole_offset = 12;  // Distance from the edges to the mounting holes
recess_depth = 2;      // Depth of the recessed holes
recess_diameter = 8;   // Diameter of the recessed holes
edge_radius = 2;       // Radius for rounded edges

// Function to create a hole
module create_hole(diameter, depth) {
    translate([0, 0, -0.1]) // Slightly offset to ensure through cut
        cylinder(d=diameter, h=depth + 0.2, center=true);
}

// Function to create a recessed hole
module create_recessed_hole(diameter, depth, recess_diameter, recess_depth) {
    difference() {
        create_hole(diameter, depth);
        translate([0, 0, -recess_depth / 2])
            cylinder(d=recess_diameter, h=recess_depth, center=true);
    }
}

// Main L-bracket
module l_bracket() {
    // Base section
    difference() {
        minkowski() {
            cube([l_bracket_length, l_bracket_width, thickness], center=false);
            sphere(r=edge_radius);
        }
        // Central hole (aligned and enlarged)
        translate([l_bracket_length / 2, l_bracket_width / 2, thickness / 2])
            create_recessed_hole(hole_diameter, thickness, recess_diameter, recess_depth);
        // Mounting holes (symmetrical placement)
        for (x = [-1, 1])
            for (y = [-1, 1])
                translate([
                    l_bracket_length / 2 + x * (l_bracket_length / 2 - mounting_hole_offset),
                    l_bracket_width / 2 + y * (l_bracket_width / 2 - mounting_hole_offset),
                    thickness / 2
                ])
                    create_recessed_hole(mounting_hole_diameter, thickness, recess_diameter, recess_depth);
    }

    // Vertical section
    translate([0, 0, thickness]) {
        difference() {
            minkowski() {
                cube([thickness, l_bracket_width, l_bracket_height], center=false);
                sphere(r=edge_radius);
            }
            // Mounting holes on the vertical section (aligned and symmetrical)
            for (y = [-1, 1])
                translate([
                    thickness / 2,
                    l_bracket_width / 2 + y * (l_bracket_width / 2 - mounting_hole_offset),
                    l_bracket_height / 2
                ])
                    rotate([90, 0, 0])
                        create_recessed_hole(mounting_hole_diameter, l_bracket_height, recess_diameter, recess_depth);
        }
    }
}

// Render the L-bracket
l_bracket();

