
// Function to create a bolt
module bolt(length = 22, diameter = 5, head_diameter = 8, head_height = 3) {
    union() {
        cylinder(h = length, d = diameter, center = false);
        translate([0, 0, length])
            cylinder(h = head_height, d = head_diameter, center = false);
    }
}

// Function to create a nut
module nut(diameter = 8, height = 4, thread_diameter = 5) {
    difference() {
        cylinder(h = height, d = diameter, center = false);
        translate([0, 0, -1])
            cylinder(h = height + 2, d = thread_diameter, center = false);
    }
}

// Creating the base block
module base_block() {
    difference() {
        cube([40, 25, 10]);
        
        // Adjusted front circular recesses for alignment
        translate([8, 5, 0])
            cylinder(h = 2, d = 5, center = false);
        translate([32, 5, 0])
            cylinder(h = 2, d = 5, center = false);

        // Correcting threaded holes alignment and sizes
        translate([10, 12.5, -1])
            cylinder(h = 12, d = 7, center = false);
        translate([30, 12.5, -1])
            cylinder(h = 12, d = 7, center = false);
    }
}

// Clamp arm left model
module clamp_arm_left() {
    difference() {
        union() {
            translate([0, 12.5, 5])
                rotate([0, 0, 90])
                    cube([5, 20, 10]);
            translate([0, 30, 5])
                rotate([0, 0, 90])
                    cube([5, 12, 10]);
        }
        // Smooth curvature improvement
        translate([15, 22.5, 10])
            rotate([0, 0, 90])
                cylinder(h = 10, r = 7);
    }
}

// Clamp arm right model
module clamp_arm_right() {
    mirror([1, 0, 0])
        clamp_arm_left();
}

// Central hollow cylinder
module central_hollow_cylinder() {
    difference() {
        cylinder(h = 35, d = 25);
        translate([0, 0, -1])
            cylinder(h = 37, d = 15);

        // Added circular grooves for connection
        for (i = [-12, -5, 5, 12])
            translate([0, 0, i])
                cylinder(h = 1.5, d = 27);
    }
}

// Assembly function
module assembly() {
    base_block();

    // Improved clamp arms positioning
    translate([-5, -15, 10])
        clamp_arm_left();
    translate([35, 20, 10])
        clamp_arm_right();

    // Central hollow cylinder with updated grooves
    translate([20, 0, 12])
        central_hollow_cylinder();

    // Proper bolt and nut placements
    translate([10, 12.5, 0])
        bolt();
    translate([30, 12.5, 0])
        bolt();

    translate([10, 12.5, -2])
        nut();
    translate([30, 12.5, -2])
        nut();
}

// Render the assembly
assembly();

