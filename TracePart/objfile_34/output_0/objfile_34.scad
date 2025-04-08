
// Parameters
flange_radius = 50;
flange_thickness = 5;
hole_radius = 3;
bolt_radius = 2;
bolt_length = 40;
nut_radius = 4;
nut_thickness = 3;
spacer_radius = 40;
spacer_thickness = 10;
hub_radius = 20;
hub_length = 30;

// Functions to create components
module flange_plate() {
    difference() {
        cylinder(h = flange_thickness, r = flange_radius);
        for (i = [0:7]) {
            rotate([0, 0, i * 45]) translate([flange_radius - 10, 0, 0])
                cylinder(h = flange_thickness + 1, r = hole_radius);
        }
        cylinder(h = flange_thickness + 1, r = hub_radius);
    }
}

module spacer_ring() {
    difference() {
        cylinder(h = spacer_thickness, r = spacer_radius);
        cylinder(h = spacer_thickness + 1, r = hub_radius);
    }
}

module central_hub() {
    cylinder(h = hub_length, r = hub_radius);
}

module bolt() {
    translate([0, 0, -bolt_length / 2])
        cylinder(h = bolt_length, r = bolt_radius);
}

module nut() {
    cylinder(h = nut_thickness, r = nut_radius);
}

// Assembly
module coupling() {
    translate([0, 0, flange_thickness / 2])
        flange_plate();

    translate([0, 0, flange_thickness + spacer_thickness / 2])
        spacer_ring();

    translate([0, 0, flange_thickness + spacer_thickness + flange_thickness / 2])
        flange_plate();

    translate([0, 0, flange_thickness + spacer_thickness + flange_thickness + hub_length / 2])
        central_hub();

    translate([0, 0, flange_thickness + spacer_thickness + flange_thickness + hub_length + flange_thickness / 2])
        flange_plate();

    translate([0, 0, flange_thickness + spacer_thickness + flange_thickness + hub_length + flange_thickness + spacer_thickness / 2])
        spacer_ring();

    translate([0, 0, flange_thickness + spacer_thickness + flange_thickness + hub_length + flange_thickness + spacer_thickness + flange_thickness / 2])
        flange_plate();

    for (i = [0:7]) {
        rotate([0, 0, i * 45]) translate([flange_radius - 10, 0, flange_thickness / 2])
            bolt();
        rotate([0, 0, i * 45]) translate([flange_radius - 10, 0, flange_thickness + spacer_thickness / 2])
            nut();
        rotate([0, 0, i * 45]) translate([flange_radius - 10, 0, flange_thickness + spacer_thickness + flange_thickness / 2])
            nut();
        rotate([0, 0, i * 45]) translate([flange_radius - 10, 0, flange_thickness + spacer_thickness + flange_thickness + hub_length + flange_thickness / 2])
            nut();
        rotate([0, 0, i * 45]) translate([flange_radius - 10, 0, flange_thickness + spacer_thickness + flange_thickness + hub_length + flange_thickness + spacer_thickness / 2])
            nut();
        rotate([0, 0, i * 45]) translate([flange_radius - 10, 0, flange_thickness + spacer_thickness + flange_thickness + hub_length + flange_thickness + spacer_thickness + flange_thickness / 2])
            nut();
    }
}

// Render the model
coupling();

