
// Define dimensions for components
module central_gear() {
    // Assuming central gear dimensions: diameter 20, height 10
    difference() {
        cylinder(d = 20, h = 10);
        cylinder(d = 5, h = 12);  // Central hole
    }
}

module outer_ring() {
    // Assuming outer ring dimensions: diameter 25, height 15
    difference() {
        cylinder(d = 25, h = 15);
        cylinder(d = 20, h = 15);  // Internal space for central gear
    }
}

module inner_ring() {
    // Assuming inner ring dimensions: diameter 22, height 10
    difference() {
        cylinder(d = 22, h = 10);
        cylinder(d = 20, h = 10);  // Internal fit for central gear
    }
}

module locking_plate() {
    // Assuming plate dimensions: diameter 25, thickness 2
    difference() {
        cylinder(d = 25, h = 2);
        for (i = [0 : 120 : 240]) {
            rotate([0, 0, i]) translate([10, 0, 0]) cylinder(d = 4, h = 3);  // Bolt holes
        }
    }
}

module groove_plate() {
    // Assuming plate with grooves dimensions: diameter 22, thickness 2
    cylinder(d = 22, h = 2);
}

module bolt() {
    // Bolt dimensions: diameter 3, length 5
    cylinder(d = 3, h = 5);
}

module nut() {
    // Nut dimensions: diameter 4, thickness 2
    cylinder(d = 4, h = 2);
}

// Assembly of components based on positional relationship
module assembly() {
    translate([0, 0, 0]) locking_plate();
    translate([0, 0, 2]) groove_plate();
    translate([0, 0, 4]) central_gear();
    translate([0, 0, 14]) groove_plate();
    translate([0, 0, 16]) locking_plate();
    translate([-12, 0, 0]) bolt();  // Bolt position example
    translate([0, 0, 19]) inner_ring();
    translate([0, 0, 19]) outer_ring();
}

// Render assembly
assembly();

