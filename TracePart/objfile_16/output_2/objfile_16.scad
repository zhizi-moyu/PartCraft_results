// Parameters for components dimensions
module input_adapter() {
    difference() {
        cylinder(h=20, d=28); // Adjusted diameter to trim excess bulk
        translate([0, 0, -1]) cylinder(h=21, d=18);
        for (i = [0:3]) {
            rotate([0, 0, i * 90]) translate([8, 0, 10]) // Updated hole alignment
            cylinder(h=20, d=5); // Refined mounting holes
        }
    }
}

module output_adapter() {
    difference() {
        cylinder(h=18, d=28); // Reduced complexity, adjusted dimensions
        translate([0, 0, -1]) cylinder(h=20, d=18);
        for (i = [0:3]) {
            rotate([0, 0, i * 90]) translate([8, 0, 10]) 
            cylinder(h=18, d=5); // Simplified mounting holes
        }
    }
}

module central_shaft() {
    cylinder(h=70, d=10); // Simplified to a smooth cylindrical surface
}

module spacer_ring() {
    difference() {
        cylinder(h=8, d=33); // Adjusted height and diameter
        translate([0, 0, -1]) cylinder(h=10, d=23); // Ensured correct positioning
    }
}

module flange_plate() {
    difference() {
        cylinder(h=8, d=48); // Adjusted thickness and diameter
        for (i = [0:5]) { // Matched original hole pattern
            rotate([0, 0, i * 60]) translate([18, 0, 4]) 
            cylinder(h=8, d=5); // Holes aligned evenly
        }
    }
}

module nut() {
    scale([0.8, 0.8, 0.8]) cylinder(h=4, d=5); // Scaled down size, improved proportions
}

module bolt() {
    cylinder(h=22, d=5); // Adjusted length and diameter
}

// Assembling the coupling in layers

module layer_1() {
    translate([0, 0, 140]) input_adapter();
}

module layer_2() {
    translate([0, 0, 132]) flange_plate();
    for (i = [0:5]) {
        rotate([0, 0, i * 60]) translate([18, 0, 132]) nut();
    }
}

module layer_3() {
    translate([0, 0, 126]) spacer_ring();
    for (i = [0:5]) {
        rotate([0, 0, i * 60]) translate([18, 0, 126]) bolt();
    }
}

module layer_4() {
    translate([0, 0, 120]) flange_plate();
    for (i = [0:5]) {
        rotate([0, 0, i * 60]) translate([18, 0, 120]) nut();
    }
}

module layer_5() {
    translate([0, 0, 105]) central_shaft();
}

module layer_6() {
    translate([0, 0, 90]) flange_plate();
    for (i = [0:5]) {
        rotate([0, 0, i * 60]) translate([18, 0, 90]) nut();
    }
}

module layer_7() {
    translate([0, 0, 84]) spacer_ring();
    for (i = [0:5]) {
        rotate([0, 0, i * 60]) translate([18, 0, 84]) bolt();
    }
}

module layer_8() {
    translate([0, 0, 78]) flange_plate();
    for (i = [0:5]) {
        rotate([0, 0, i * 60]) translate([18, 0, 78]) nut();
    }
}

module layer_9() {
    translate([0, 0, 70]) output_adapter();
}

// Final assembly
module flexible_coupling() {
    layer_1();
    layer_2();
    layer_3();
    layer_4();
    layer_5();
    layer_6();
    layer_7();
    layer_8();
    layer_9();
}

// Render the model
flexible_coupling();
