
// Parameters
cylinder_diameter = 30;
cylinder_length = 40;
hole_diameter = 10;
groove_width = 4;
groove_depth = 2;
num_grooves = 3;
pin_diameter = 6;
pin_length = 50;
screw_slot_width = 12;
screw_slot_depth = 6;
screw_diameter = 4;

// Function to create grooves
module cylinder_with_grooves() {
    difference() {
        cylinder(d = cylinder_diameter, h = cylinder_length, center = true);
        cylinder(d = hole_diameter, h = cylinder_length + 2, center = true);
        for (i = [1:num_grooves]) {
            translate([0, 0, cylinder_length/2 - groove_width*i])
                cylinder(d = cylinder_diameter + 2, h = groove_depth, center = true);
        }
        for (pos = [-cylinder_length/4, cylinder_length/4]) {
            rotate([90, 0, 0])
                translate([pos, 0, -screw_slot_depth/2])
                    cube([screw_slot_depth, screw_slot_width, screw_slot_width], center = true);
        }
    }
}

// Module for central pin shaft
module central_pin() {
    translate([-pin_length/2, 0, 0])
        cylinder(d = pin_diameter, h = pin_length, center = true);
}

// Module for adjustment slot with screws
module adjustment_screw() {
    translate([cylinder_length/4, 0, cylinder_diameter/2 + groove_depth])
        rotate([0, 90, 0])
            cylinder(d = screw_diameter, h = screw_slot_depth, center = true);
    translate([-cylinder_length/4, 0, cylinder_diameter/2 + groove_depth])
        rotate([0, 90, 0])
            cylinder(d = screw_diameter, h = screw_slot_depth, center = true);
}

// Assemble all components
module flexible_coupling() {
    cylinder_with_grooves();
    central_pin();
    adjustment_screw();
}

// Render the model
flexible_coupling();

