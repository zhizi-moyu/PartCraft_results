
// Function to create a bolt
module bolt(length = 20, diameter = 5, head_diameter = 8, head_height = 3) {
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
        translate([5, 5, -1])
            cylinder(h = 12, d = 7, center = false); // Recesses
        translate([20, 25, 5])
            rotate([90, 0, 0])
                cylinder(h = 10, d = 5); // Threaded holes on the sides
    }
}

// Clamp arm left model
module clamp_arm_left() {
    // Just a placeholder shape, to be updated as per the actual dimensions
    translate([0, 12.5, 5])
        rotate([0, 0, 90])
            cube([5, 20, 10]); // Basic block for clamp arm
}

// Clamp arm right is a mirrored version
module clamp_arm_right() {
    mirror([1, 0, 0])
        clamp_arm_left();
}

// Central hollow cylinder
module central_hollow_cylinder() {
    difference() {
        cylinder(h = 30, d = 25);
        translate([0, 0, -1])
            cylinder(h = 32, d = 15); // Hollow center
        for (i = [-10, 0, 10])
            translate([0, 0, i])
                cylinder(h = 2, d = 27); // Circular grooves
    }
}

// Assembly function
module assembly() {
    base_block();

    // Positioning clamp arms and the central cylinder
    translate([0, -15, 10])
        clamp_arm_left();
    translate([30, 15, 10])
        clamp_arm_right();

    translate([20, 0, 10])
        central_hollow_cylinder();
    
    // Bolt and nut placements
    for (i = [0, 1]) {
        translate([7, 12 * i * 2, 0])
            bolt();
        translate([7, 12 * i * 2, -2])
            nut();
    }
}

// Render assembly
assembly();

