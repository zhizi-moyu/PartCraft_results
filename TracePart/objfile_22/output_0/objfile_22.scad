```scad
// Central Shaft
module central_shaft() {
    cylinder(h = 50, d = 20, $fn = 100); // Main cylindrical body
}

// Input Shaft
module input_shaft() {
    difference() {
        cylinder(h = 30, d = 20, $fn = 100); // Solid cylindrical piece
        translate([0, 0, 15])
            cylinder(h = 15, d = 10, $fn = 100); // Hole on one side
    }
}

// Output Shaft
module output_shaft() {
    difference() {
        cylinder(h = 30, d = 20, $fn = 100); // Solid cylindrical piece
        translate([0, 0, 15])
            cylinder(h = 15, d = 10, $fn = 100); // Hole on one side
    }
}

// Spacer Ring
module spacer_ring() {
    difference() {
        cylinder(h = 5, d = 20, $fn = 100); // Outer ring
        translate([0, 0, 0])
            cylinder(h = 5, d = 15, $fn = 100); // Hollow center
    }
}

// Flange Plate
module flange_plate() {
    difference() {
        cylinder(h = 5, d = 30, $fn = 100); // Flat plate
        translate([0, 0, 0])
            cylinder(h = 5, d = 20, $fn = 100); // Hollow center
        // Bolt holes
        for (i = [0, 90, 180, 270]) {
            rotate([0, 0, i])
                translate([12, 0, 0])
                    cylinder(h = 5, d = 5, $fn = 100);
        }
    }
}

// Nut
module nut() {
    cylinder(h = 5, d = 7, $fn = 6); // Hexagonal cylinder
}

// Bolt
module bolt() {
    union() {
        cylinder(h = 25, d = 4, $fn = 100); // Shaft
        translate([0, 0, 25])
            cylinder(h = 2, d = 6, $fn = 6); // Hexagonal head
    }
}

// Assembly
module assembly() {
    // Central Shaft
    central_shaft();
    
    // Spacers
    translate([0, 0, 15])
        spacer_ring();
    translate([0, 0, 35])
        spacer_ring();
    
    // Flange Plates
    translate([0, 0, 5])
        flange_plate();
    translate([0, 0, 45])
        flange_plate();
    
    // Input and Output Shafts
    translate([0, 0, -30])
        input_shaft();
    translate([0, 0, 80])
        output_shaft();
    
    // Nuts and Bolts (Adding for demonstration; placement requires positional refinement)
    for (i = [0, 90, 180, 270]) {
        rotate([0, 0, i])
            translate([10, 0, 0])
                nut();
        rotate([0, 0, i])
            translate([10, 0, 20])
                bolt();
    }
}

// Render the complete assembly
assembly();
```

