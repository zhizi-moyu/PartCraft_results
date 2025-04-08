
// Parameters for components
module central_shaft() {
    difference() {
        cylinder(h=30, d=20);
        translate([0, 0, -1]) cylinder(h=32, d=10);
    }
}

module input_shaft() {
    difference() {
        cylinder(h=20, d=20);
        translate([0, 0, -1]) cylinder(h=22, d=10);
    }
}

module output_shaft() {
    difference() {
        cylinder(h=20, d=20);
        translate([0, 0, -1]) cylinder(h=22, d=10);
    }
}

module spacer_ring() {
    difference() {
        cylinder(h=5, d=20);
        translate([0, 0, -1]) cylinder(h=6, d=15);
    }
}

module flange_plate() {
    difference() {
        cylinder(h=5, d=30);
        translate([0, 0, -1]) cylinder(h=6, d=20);
        for (i = [0:3]) rotate([0, 0, i * 90]) translate([12, 0, 0]) cylinder(h=5, d=3);
    }
}

module nut() {
    cylinder(h=5, d=6);
}

module bolt() {
    cylinder(h=30, d=3);
}

// Assembly
module flexible_coupling() {
    // Layer 1: Input Shaft
    translate([0, 0, 0]) input_shaft();
    
    // Layer 2: Flange Plate 1 with Nuts
    translate([0, 0, 20]) flange_plate();
    for (i = [0:3]) rotate([0, 0, i * 90]) translate([12, 0, 25]) nut();
    
    // Layer 3: Spacer Ring 1 with Bolts
    translate([0, 0, 25]) spacer_ring();
    for (i = [0:3]) rotate([0, 0, i * 90]) translate([12, 0, 30]) bolt();
    
    // Layer 4: Flange Plate 2 with Nuts
    translate([0, 0, 30]) flange_plate();
    for (i = [0:3]) rotate([0, 0, i * 90]) translate([12, 0, 35]) nut();
    
    // Layer 5: Central Shaft
    translate([0, 0, 35]) central_shaft();
    
    // Layer 6: Flange Plate 3 with Nuts
    translate([0, 0, 65]) flange_plate();
    for (i = [0:3]) rotate([0, 0, i * 90]) translate([12, 0, 70]) nut();
    
    // Layer 7: Spacer Ring 2 with Bolts
    translate([0, 0, 70]) spacer_ring();
    for (i = [0:3]) rotate([0, 0, i * 90]) translate([12, 0, 75]) bolt();
    
    // Layer 8: Flange Plate 4 with Nuts
    translate([0, 0, 75]) flange_plate();
    for (i = [0:3]) rotate([0, 0, i * 90]) translate([12, 0, 80]) nut();
    
    // Layer 9: Output Shaft
    translate([0, 0, 80]) output_shaft();
}

// Render the assembly
flexible_coupling();

