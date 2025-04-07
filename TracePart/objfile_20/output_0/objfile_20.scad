
// Universal variables
cylinder_radius = 5; // Radius of bolts and nuts
flange_radius = 20; // Radius of flange plates
spacer_ring_outer_radius = 15; // Outer radius of spacer rings
spacer_ring_inner_radius = 8; // Inner radius of spacer rings
central_shaft_radius = 6; // Radius of central shaft
height_unit = 5; // Height of single unit (bolt, nut, etc.)

// Central shaft
module central_shaft(length = 50) {
    cylinder(r=central_shaft_radius, h=length);
}

// Flange plate
module flange_plate(thickness = height_unit, hole_count = 4) {
    difference() {
        cylinder(r=flange_radius, h=thickness);
        for (i = [0:hole_count-1]) {
            rotate([0, 0, i * 360 / hole_count])
                translate([flange_radius-5, 0, 0])
                cylinder(r=cylinder_radius, h=thickness + 1);
        }
    }
}

// Spacer ring
module spacer_ring(thickness = height_unit) {
    difference() {
        cylinder(r=spacer_ring_outer_radius, h=thickness);
        cylinder(r=spacer_ring_inner_radius, h=thickness + 1);
    }
}

// Nut
module nut(thickness = height_unit, radius = cylinder_radius+2) {
    cylinder(r=radius, h=thickness);
}

// Bolt
module bolt(length = 30, radius = cylinder_radius) {
    cylinder(r=radius, h=length);
}

// Combine layers
union() {
    translate([0, 0, height_unit]) {
        // Layer 1: Top flange plate with nuts
        flange_plate();
        translate([0, 0, height_unit]) nut();
        translate([0, 0, height_unit * 2]) nut();
    }

    translate([0, 0, height_unit * 3]) {
        // Layer 2: Spacer ring with bolts
        spacer_ring();
        rotate([0, 0, 90]) bolt(height_unit * 3);
    }

    translate([0, 0, height_unit * 7]) {
        // Layer 3: Second flange plate with nuts
        flange_plate();
        translate([0, 0, height_unit]) nut();
        translate([0, 0, height_unit * 2]) nut();
    }

    translate([0, 0, height_unit * 10]) {
        // Layer 4: Central shaft
        central_shaft(height_unit * 8);
    }

    translate([0, 0, height_unit * 16]) {
        // Layer 5: Third flange plate with nuts
        flange_plate();
        translate([0, 0, height_unit]) nut();
        translate([0, 0, height_unit * 2]) nut();
    }

    translate([0, 0, height_unit * 19]) {
        // Layer 6: Spacer ring with bolts
        spacer_ring();
        rotate([0, 0, 90]) bolt(height_unit * 3);
    }

    translate([0, 0, height_unit * 23]) {
        // Layer 7: Bottom flange plate with nuts
        flange_plate();
        translate([0, 0, height_unit]) nut();
        translate([0, 0, height_unit * 2]) nut();
    }
}

