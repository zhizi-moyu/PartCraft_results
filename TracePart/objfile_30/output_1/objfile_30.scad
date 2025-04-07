
// Define dimensions for components
module central_gear() {
    // Adjusting central gear with deeper grooves and refined dimensions
    difference() {
        cylinder(d = 21, h = 10);
        cylinder(d = 5.5, h = 12);  // Central hole resized and realigned
        for (i = [0:360/12:360]) {  // Example groove pattern
            rotate([0,0,i]) translate([10.5,0,5]) cylinder(d = 1, h = 5); 
        }
    }
}

module outer_ring() {
    // Correcting outer ring's grooves and thickness
    difference() {
        cylinder(d = 25, h = 13);  // Reduced thickness
        cylinder(d = 21, h = 13);

        for (i = [0:360/8:360]) {
            rotate([0,0,i]) translate([12.5,0,7]) cylinder(d = 0.8, h = 15);
        }
    }
}

module inner_ring() {
    // Adding internal grooves for a snug fit
    difference() {
        cylinder(d = 22, h = 10);
        cylinder(d = 20, h = 10);  

        for (i = [0:360/6:360]) {
            rotate([0,0,i]) translate([11,0,5]) cylinder(d = 0.6, h = 10);
        }
    }
}

module locking_plate() {
    // Correcting bolt hole spacing and surface flatness
    difference() {
        cylinder(d = 25, h = 2);
        for (i = [0:120:360]) {
            rotate([0, 0, i]) translate([10.5, 0, 0]) cylinder(d = 3.5, h = 3);  // Adjusted bolt holes
        }
    }
}

module groove_plate() {
    // Aligning grooves correctly
    difference() {
        cylinder(d = 22, h = 2);
        for (i = [0:360/8:360]) {
            rotate([0,0,i]) translate([11,0,1]) cylinder(d = 0.5, h = 2);
        }
    }
}

module bolt() {
    // Resizing bolts for thicker and longer profile
    difference() {
        cylinder(d = 3.5, h = 7);
        translate([0,0,5]) rotate([0,0,30]) cylinder(d = 4, h = 3);  // Hexagonal head correction
    }
}

module nut() {
    // Resizing nuts for accurate fit and hexagon shape
    cylinder(d = 5, h = 3);
    translate([0,0,1.5]) rotate([0,0,30]) cylinder(d = 4, h = 2);
}

// Assembly of components based on positional relationship
module assembly() {
    translate([0, 0, 0]) locking_plate();
    translate([0, 0, 2]) groove_plate();
    translate([0, 0, 4]) central_gear();
    translate([0, 0, 14]) groove_plate();
    translate([0, 0, 16]) locking_plate();
    translate([-12, 0, 0]) bolt();  
    translate([0, 0, 19]) inner_ring();
    translate([0, 0, 19]) outer_ring();
}

// Render assembly
assembly();

