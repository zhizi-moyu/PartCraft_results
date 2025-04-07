
// Parameters for components dimensions
module input_adapter() {
    difference() {
        cylinder(h=20, d=30);
        translate([0, 0, -1]) cylinder(h=22, d=20);
        for (i = [0:3]) {
            rotate([0, 0, i * 90]) translate([10, 0, 10])
            cylinder(h=20, d=6); // Mounting holes
        }
    }
}

module output_adapter() {
    difference() {
        cylinder(h=20, d=30);
        translate([0, 0, -1]) cylinder(h=22, d=20);
        for (i = [0:3]) {
            rotate([0, 0, i * 90]) translate([10, 0, 10])
            cylinder(h=20, d=6); // Mounting holes
        }
    }
}

module central_shaft() {
    cylinder(h=75, d=10); // Length extended for full connection
}

module spacer_ring() {
    difference() {
        cylinder(h=10, d=35); // Increased thickness
        translate([0, 0, -1]) cylinder(h=12, d=25);
    }
}

module flange_plate() {
    difference() {
        cylinder(h=10, d=50);
        for (i = [0:5]) { // Increased number of holes
            rotate([0, 0, i * 60]) translate([20, 0, 5])
            cylinder(h=10, d=6); // Holes for nuts/bolts
        }
    }
}

module nut() {
    cylinder(h=5, d=6);
}

module bolt() {
    cylinder(h=25, d=6);
}

// Assembling the coupling in layers

module layer_1() {
    translate([0, 0, 145]) input_adapter();
}

module layer_2() {
    translate([0, 0, 135]) flange_plate();
    for (i = [0:5]) { // Increased number of connections
        rotate([0, 0, i * 60]) translate([20, 0, 135])
        nut();
    }
}

module layer_3() {
    translate([0, 0, 130]) spacer_ring();
    for (i = [0:5]) { // Increased bolt connections
        rotate([0, 0, i * 60]) translate([20, 0, 130])
        bolt();
    }
}

module layer_4() {
    translate([0, 0, 125]) flange_plate();
    for (i = [0:5]) {
        rotate([0, 0, i * 60]) translate([20, 0, 125])
        nut();
    }
}

module layer_5() {
    translate([0, 0, 110]) central_shaft();
}

module layer_6() {
    translate([0, 0, 95]) flange_plate();
    for (i = [0:5]) {
        rotate([0, 0, i * 60]) translate([20, 0, 95])
        nut();
    }
}

module layer_7() {
    translate([0, 0, 90]) spacer_ring();
    for (i = [0:5]) {
        rotate([0, 0, i * 60]) translate([20, 0, 90])
        bolt();
    }
}

module layer_8() {
    translate([0, 0, 85]) flange_plate();
    for (i = [0:5]) {
        rotate([0, 0, i * 60]) translate([20, 0, 85])
        nut();
    }
}

module layer_9() {
    translate([0, 0, 75]) output_adapter();
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

