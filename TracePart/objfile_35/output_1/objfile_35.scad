
// Parameters for components
module central_shaft() {
    difference() {
        cylinder(h=30, d=15); // Reduced diameter
        translate([0, 0, -1]) cylinder(h=32, d=8); // Hollowed center
    }
}

module input_shaft() {
    difference() {
        cylinder(h=25, d=20); // Extended length
        translate([0, 0, -1]) cylinder(h=27, d=10);
        translate([0, 0, 22]) cube([10, 10, 3], center=true); // Defined flat face
    }
}

module output_shaft() {
    difference() {
        cylinder(h=25, d=20); // Adjusted length
        translate([0, 0, -1]) cylinder(h=27, d=10);
        translate([0, 0, 22]) cube([10, 10, 3], center=true); // Defined flat face
    }
}

module spacer_ring() {
    difference() {
        cylinder(h=3, d=20); // Reduced thickness
        translate([0, 0, -1]) cylinder(h=4, d=15);
    }
}

module flange_plate() {
    difference() {
        cylinder(h=5, d=35); // Increased diameter
        translate([0, 0, -1]) cylinder(h=6, d=25);
        for (i = [0:5]) rotate([0, 0, i * 60]) translate([15, 0, 0]) cylinder(h=5, d=3); // Increased bolt holes
    }
}

module nut() {
    difference() {
        cylinder(h=4, d=5); // Reduced size
        translate([0, 0, 0]) rotate([0, 0, 0]) cylinder(h=4, d=3); // Sharpened edges
    }
}

module bolt() {
    cylinder(h=35, d=3); // Increased length
}

// Assembly
module flexible_coupling() {
    // Layer 1: Input Shaft
    translate([0, 0, 0]) input_shaft();
    
    // Layer 2: Flange Plate 1 with Nuts
    translate([0, 0, 25]) flange_plate();
    for (i = [0:5]) rotate([0, 0, i * 60]) translate([15, 0, 30]) nut();
    
    // Layer 3: Spacer Ring 1 with Bolts
    translate([0, 0, 30]) spacer_ring();
    for (i = [0:5]) rotate([0, 0, i * 60]) translate([15, 0, 33]) bolt();
    
    // Layer 4: Flange Plate 2 with Nuts
    translate([0, 0, 33]) flange_plate();
    for (i = [0:5]) rotate([0, 0, i * 60]) translate([15, 0, 38]) nut();
    
    // Layer 5: Central Shaft
    translate([0, 0, 38]) central_shaft();
    
    // Layer 6: Flange Plate 3 with Nuts
    translate([0, 0, 68]) flange_plate();
    for (i = [0:5]) rotate([0, 0, i * 60]) translate([15, 0, 73]) nut();
    
    // Layer 7: Spacer Ring 2 with Bolts
    translate([0, 0, 73]) spacer_ring();
    for (i = [0:5]) rotate([0, 0, i * 60]) translate([15, 0, 76]) bolt();
    
    // Layer 8: Flange Plate 4 with Nuts
    translate([0, 0, 76]) flange_plate();
    for (i = [0:5]) rotate([0, 0, i * 60]) translate([15, 0, 81]) nut();
    
    // Layer 9: Output Shaft
    translate([0, 0, 81]) output_shaft();
}

// Render the assembly
flexible_coupling();

