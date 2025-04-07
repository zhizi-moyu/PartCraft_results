
// Definitions for individual components
module support_block() {
    cube([12, 24, 6]); // Increase size and sharpen edges
}

module base_block() {
    difference() {
        cube([40, 20, 10]); // Cuboid base
        translate([33, 0, 1]) {
            cube([7, 20, 11]); // Sharpen tapered edge and adjust alignment
        }
    }
}

module angled_extension() {
    polyhedron(
        points = [
            [0, 0, 0],   // Bottom-left
            [30, 0, 0],  // Bottom-right
            [30, 20, 0], // Top-right
            [-5, 20, 15], // Adjust Top-left inward and higher for steeper angle
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
    translate([36, 0, 0]) { support_block(); } // Space wider

    // Layer 2 - Base Block
    translate([4, 0, 6]) { base_block(); } // Adjust alignment

    // Layer 3 - Angled Extension
    translate([0, -5, 17]) { angled_extension(); } // Position higher and inward
}

// Render the 3D model
flexible_coupling();

