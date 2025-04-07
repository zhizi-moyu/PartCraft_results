// Definitions for individual components
module support_block() {
    cube([10, 20, 4]); // Resize to ensure clean, sharp-rectangular edges
}

module base_block() {
    difference() {
        cube([42, 22, 12]); // Increased thickness for the base block
        translate([35, 0, 1]) {
            cube([7, 20, 13]); // Refine to form a proper trapezoidal profile
        }
    }
}

module angled_extension() {
    polyhedron(
        points = [
            [0, 0, 0],    // Bottom-left
            [30, 0, 0],   // Bottom-right
            [30, 20, 0],  // Top-right
            [0, 20, 20], // Adjust to create sharper slope with an acute angle
        ],
        faces = [
            [0, 1, 2],
            [0, 2, 3],
            [1, 2, 3],
            [0, 1, 3],
        ]
    );
}

// Combining layers to create the 3D model
module flexible_coupling() {
    // Layer 1 - Support Blocks
    translate([0, 0, 0]) { support_block(); }
    translate([32, 0, 0]) { support_block(); } // Align symmetrically with base block

    // Layer 2 - Base Block
    translate([2, 0, 8]) { base_block(); } // Adjust alignment and elevation

    // Layer 3 - Angled Extension
    translate([0, 0, 20]) { angled_extension(); } // Adjust position closer to base block
}

// Render the 3D model
flexible_coupling();
