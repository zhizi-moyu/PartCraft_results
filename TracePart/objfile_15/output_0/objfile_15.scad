
// Parameters for dimensions
central_hub_diameter = 30;
central_hub_height = 20;
central_hub_hole_diameter = 10;

outer_block_width = 15;
outer_block_height = 20;
outer_block_depth = 40;
outer_block_curve_radius = 7.5;
bolt_hole_diameter = 8;

spacer_ring_diameter = 30;
spacer_ring_thickness = 5;
spacer_ring_hole_diameter = 10;

bolt_diameter = 8;
bolt_length = 50;

nut_diameter = 10;
nut_thickness = 5;

// Component generation
module central_hub() {
    difference() {
        cylinder(h = central_hub_height, d = central_hub_diameter);
        cylinder(h = central_hub_height + 1, d = central_hub_hole_diameter);
    }
}

module outer_block() {
    difference() {
        hull() {
            translate([-outer_block_depth / 2, 0, 0])
                cylinder(h = outer_block_height, r = outer_block_curve_radius);
            translate([outer_block_depth / 2, 0, 0])
                cylinder(h = outer_block_height, r = outer_block_curve_radius);
        }
        translate([0, 0, outer_block_height / 3])
            rotate([0, 90, 0])
                cylinder(d = bolt_hole_diameter, h = outer_block_depth + 2);
    }
}

module spacer_ring() {
    difference() {
        cylinder(h = spacer_ring_thickness, d = spacer_ring_diameter);
        cylinder(h = spacer_ring_thickness + 1, d = spacer_ring_hole_diameter);
    }
}

module bolt() {
    cylinder(h = bolt_length, d = bolt_diameter);
}

module nut() {
    difference() {
        cylinder(h = nut_thickness, d = nut_diameter);
        for (i = [0, 60, 120, 180, 240, 300])
            rotate([0, 0, i])
                translate([nut_diameter / 2, 0, nut_thickness / 2])
                    cube([5, 2, nut_thickness], center = true);
    }
}

// Assembly generation
module assembly() {
    translate([0, 0, spacer_ring_thickness * -1]) spacer_ring();
    translate([0, 0, central_hub_height / 2]) central_hub();
    for (angle = [0, 180]) {
        translate([0, spacer_ring_diameter / 2, angle - central_hub_height / 2])
            rotate([0, 90, angle]) outer_block();
    }
    for (p = [-spacer_ring_diameter / 3, spacer_ring_diameter / 3]) {
        translate([p, spacer_ring_diameter / 2, angle * -6]) bolt();
        translate([p, spacer_ring_diameter / 2, angle - 5]) nut();
    }
}

// Render final model
assembly();

