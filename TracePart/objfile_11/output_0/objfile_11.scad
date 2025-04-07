
// Define dimensions
pin_length = 10;
pin_diameter = 4;

central_cylinder_height = 30;
central_cylinder_diameter = 20;

grooved_cylinder_height = 20;
grooved_cylinder_diameter = 20;

set_screw_diameter = 3;
set_screw_length = 6;

// Module for the pin
module pin() {
    cylinder(h = pin_length, d = pin_diameter);
}

// Module for the central cylinder
module central_cylinder() {
    translate([0, 0, -central_cylinder_height / 2])
        cylinder(h = central_cylinder_height, d = central_cylinder_diameter, center = true);
}

// Module for the grooved cylinder
module grooved_cylinder() {
    difference() {
        cylinder(h = grooved_cylinder_height, d = grooved_cylinder_diameter, center = true);

        // Create grooves
        for (i = [1:3])
            translate([0, 0, i * 6])
                cylinder(h = 1, d = grooved_cylinder_diameter + 2);

        // Create central hole
        translate([0, 0, -grooved_cylinder_height / 2])
            cylinder(h = grooved_cylinder_height, d = pin_diameter);
    }
}

// Module for the set screw
module set_screw() {
    translate([grooved_cylinder_diameter / 2 - set_screw_diameter / 2, 0, pin_length / 2])
        rotate([0, -90, 0])
            cylinder(h = set_screw_length, d = set_screw_diameter);
}

// Assembly
module assembly() {
    translate([0, 0, grooved_cylinder_height / 2])
        pin();

    translate([0, 0, 0])
        central_cylinder();

    translate([0, 0, -grooved_cylinder_height / 2])
        grooved_cylinder();

    set_screw();
}

translate([0, 0, pin_length])
    assembly();

