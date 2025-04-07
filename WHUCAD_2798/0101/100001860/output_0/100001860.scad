
// Define the components

// 1. Small Triangular Pyramid
module small_triangular_pyramid(size = 15) {
    polyhedron(
        points = [[0, 0, 0], [size, 0, 0], [size / 2, size, 0], [size / 2, size / 2, size]],
        faces = [[0, 1, 2], [0, 1, 3], [1, 2, 3], [2, 0, 3]]
    );
}

// 2. Semi Cylindrical Cap
module semi_cylindrical_cap(radius = 20, height = 10) {
    difference() {
        rotate([90, 0, 0]) cylinder(r = radius, h = height);
        translate([-radius - 1, -radius - 1, -height - 1])
            cube([2 * radius + 2, radius + 2, height + 2]);
    }
}

// 3. Curved Block
module curved_block(length = 60, width = 40, height = 20) {
    difference() {
        cube([length, width, height], true);
        translate([-length / 2, -length / 2, -20])
            rotate([90, 0, 0]) cylinder(r = length / 2, h = height * 2);
    }
}

// 4. Flat Triangular Prism
module flat_triangular_prism(base = 60, height = 20, width = 40) {
    linear_extrude(height = width)
        polygon(points = [[0, 0], [base, 0], [base / 2, height]]);
}

// 5. Slightly Curved Rectangular Block
module slightly_curved_rectangular_block(length = 60, width = 40, depth = 10) {
    difference() {
        cube([length, width, depth], true);
        translate([0, -length, -depth])
            rotate([90, 0, 0]) cylinder(r = length, h = depth + 1);
    }
}

// Assembling the layers

// Layer 1: Small Triangular Pyramid (apex)
translate([0, 0, 90])
    small_triangular_pyramid(15);

// Layer 2: Semi Cylindrical Cap
translate([0, 0, 70])
    semi_cylindrical_cap(20, 10);

// Layer 3: Curved Block
translate([0, 0, 50])
    curved_block(60, 40, 20);

// Layer 4: Flat Triangular Prism and Slightly Curved Rectangular Block
translate([-30, 0, 10])
    flat_triangular_prism(60, 20, 40);

translate([30, 0, 10])
    slightly_curved_rectangular_block(60, 40, 10);

