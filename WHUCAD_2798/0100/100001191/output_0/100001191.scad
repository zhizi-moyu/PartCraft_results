
// Definitions for individual components
module support_block() {
    cube([10, 20, 5]);
}

module base_block() {
    difference() {
        cube([40, 20, 10]); // Cuboid base
        translate([35, 0, 0]) {
            cube([5, 20, 10]); // Tapered subtraction for trapezoidal profile
        }
    }
}

module angled_extension() {
    polyhedron(
        points = [
            [0, 0, 0],   // Bottom-left
            [30, 0, 0],  // Bottom-right
            [30, 20, 0], // Top-right
            [0, 20, 10], // Top-left
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
    translate([30, 0, 0]) { support_block(); }

    // Layer 2 - Base Block
    translate([5, 0, 5]) { base_block(); }

    // Layer 3 - Angled Extension
    translate([0, -10, 15]) { angled_extension(); }
}

// Render the 3D model
flexible_coupling();

