
// Parameters for components
module central_shaft() {
    difference() {
        cylinder(h=35, d=15); // Increased length
        translate([0, 0, -2]) cylinder(h=37, d=8); // Deepened hollowed center
    }
}

module input_shaft() {
    difference() {
        cylinder(h=25, d=20); // Retained length
        translate([0, 0, -2]) cylinder(h=27, d=10); // Further recessed hollow center
        translate([0, 0, 22]) cube([10, 10, 3], center=true); // Defined flat face
    }
}

module output_shaft() {
    difference() {
        cylinder(h=25, d=20); // Retained length
        translate([0, 0, -2]) cylinder(h=27, d=10); // Further recessed hollow center
        translate([0, 0, 22]) cube([10, 10, 3], center=true); // Defined flat face
    }
}

module spacer_ring() {
    difference() {
        cylinder(h=2.5, d=20); // Reduced thickness
        translate([0, 0, -1]) cylinder(h=3.5, d=15); // Polished surface
    }
}

module flange_plate() {
    difference() {
        cylinder(h=5, d=35); // Retained diameter
        translate([0, 0, -1]) cylinder(h=6, d=25);
        for (i = [0:7]) rotate([0, 0, i * 45]) translate([15, 0, 0]) cylinder(h=5, d=3); // Added more bolt holes
    }
}

module nut() {
    difference() {
        cylinder(h=4, d=5); // Retained size
        translate([0, 0, 0]) rotate([0, 0, 0]) cylinder(h=4, d=3); // Sharpened edges
    }
}

module bolt() {
    cylinder(h=35, d=3); // Retained length
    // Added threading for bolts
    for (z = [0:5:35]) translate([0, 0, z]) cylinder(h=2, d=3.5);
}

// Assembly
module flexible_coupling() {
    // Layer 1: Input Shaft
    translate([0, 0, 0]) input_shaft();
    
    // Layer 2: Flange Plate 1 with Nuts
    translate([0, 0, 25]) flange_plate();
    for (i = [0:7]) rotate([0, 0, i * 45]) translate([15, 0, 30]) nut();
    
    // Layer 3: Spacer Ring 1 with Bolts
    translate([0, 0, 30]) spacer_ring();
    for (i = [0:7]) rotate([0, 0, i * 45]) translate([15, 0, 33]) bolt();
    
    // Layer 4: Flange Plate 2 with Nuts
    translate([0, 0, 33]) flange_plate();
    for (i = [0:7]) rotate([0, 0, i * 45]) translate([15, 0, 38]) nut();
    
    // Layer 5: Central Shaft
    translate([0, 0, 38]) central_shaft();
    
    // Layer 6: Flange Plate 3 with Nuts
    translate([0, 0, 73]) flange_plate();
    for (i = [0:7]) rotate([0, 0, i * 45]) translate([15, 0, 78]) nut();
    
    // Layer 7: Spacer Ring 2 with Bolts
    translate([0, 0, 78]) spacer_ring();
    for (i = [0:7]) rotate([0, 0, i * 45]) translate([15, 0, 81]) bolt();
    
    // Layer 8: Flange Plate 4 with Nuts
    translate([0, 0, 81]) flange_plate();
    for (i = [0:7]) rotate([0, 0, i * 45]) translate([15, 0, 86]) nut();
    
    // Layer 9: Output Shaft
    translate([0, 0, 86]) output_shaft();
}

// Render the assembly
flexible_coupling();

