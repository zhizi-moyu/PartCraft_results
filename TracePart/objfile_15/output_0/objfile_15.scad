
// Parameters
circular_flange_diameter = 50; // Example value
circular_flange_height = 5;
central_hole_diameter = 20;
bolt_hole_diameter = 5;
spacer_block_width = 45;
spacer_block_height = 20;
spacer_block_depth = 20;
bolt_length = 70;
bolt_diameter = 4;
nut_diameter = bolt_diameter + 6;
nut_thickness = 4;

module circular_flange() {
    difference() {
        cylinder(h = circular_flange_height, d = circular_flange_diameter);
        // Central hole
        translate([0, 0, -1]) cylinder(h = circular_flange_height + 2, d = central_hole_diameter);
        // Bolt holes
        for (angle = [0 : 90 : 270]) {
            translate([circular_flange_diameter/3*cos(angle), circular_flange_diameter/3*sin(angle), -1])
                cylinder(h = circular_flange_height + 2, d = bolt_hole_diameter);
        }
    }
}

module spacer_block() {
    cube([spacer_block_width, spacer_block_depth, spacer_block_height], center = true);
}

module bolt() {
    cylinder(h = bolt_length, d = bolt_diameter);
}

module nut() {
    translate([0, 0, bolt_length - nut_thickness])
        cylinder(h = nut_thickness, d = nut_diameter, center = true);
}

// Assembly layers
module layer1() {
    circular_flange();
    for (angle = [0 : 90 : 270]) {
        translate([circular_flange_diameter/3*cos(angle), circular_flange_diameter/3*sin(angle), circular_flange_height/2])
            nut();
    }
    translate([0, 0, circular_flange_height/2]) bolt();
}

module layer2() {
    translate([0, 0, -spacer_block_height/2])
        spacer_block();
    translate([0, 0, circular_flange_height + spacer_block_height/2])
        bolt();
}

module layer3() {
    translate([0, 0, -spacer_block_height * 1.5])
        spacer_block();
    translate([0, 0, circular_flange_height + spacer_block_height * 1.5])
        bolt();
}

module layer4() {
    translate([0, 0, -spacer_block_height * 2.5])
        spacer_block();
    translate([0, 0, circular_flange_height + spacer_block_height * 2.5])
        bolt();
}

module layer5() {
    translate([0, 0, -circular_flange_height - spacer_block_height * 3])
        circular_flange();
    for (angle = [0 : 90 : 270]) {
        translate([circular_flange_diameter/3*cos(angle), circular_flange_diameter/3*sin(angle), -circular_flange_height - spacer_block_height*3 + circular_flange_height/2])
            nut();
    }
}

difference() {
    layer1();
    layer2();
    layer3();
    layer4();
    layer5();
}

