
// Define Main Body
module main_body() {
    difference() {
        cylinder(h=50, d=30);
        for (i = [0 : 90 : 270]) {
            rotate([0, 0, i])
                translate([0, 0, 10])
                    cube([30, 10, 25], center = true);
        }
    }
}

// Define Slotted Disc
module slotted_disc() {
    difference() {
        cylinder(h=5, d=30);
        for (j = [-15, 15]) {
            rotate([0, 0, 45])
                translate([j, 0, 0])
                    cube([10, 30, 5], center = true);
        }
    }
}

// Define Fastening Bolt
module fastening_bolt() {
    union() {
        cylinder(h=10, d=4);
        translate([0, 0, 10])
            cylinder(h=5, d=6);
    }
}

// Define Screw Hole
module screw_hole() {
    cylinder(h=12, d=4);
}

// Assemble Components
module assemble() {
    main_body();
    translate([0, 0, 0])
        screw_hole();
    translate([30, 0, 0])
        screw_hole();
    for (k = [-15 : 15 : 30]) {
        translate([k, 0, 20])
            slotted_disc();
    }
    translate([0, 0, 48])
        fastening_bolt();
    translate([30, 0, 48])
        fastening_bolt();
}

// Call to Assemble
assemble();

