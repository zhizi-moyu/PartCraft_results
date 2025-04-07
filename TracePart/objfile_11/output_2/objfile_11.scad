// Parameters
cylinder_diameter = 30;
cylinder_length = 40;
hole_diameter = 10;
groove_width = 4;
groove_depth = 2.5; // Adjusted groove depth for uniformity
num_grooves = 3;
pin_diameter = 6;
pin_length = 40; // Shortened pin length for consistency
screw_slot_width = 10; // Adjusted screw slot width for visibility
screw_slot_depth = 4; // Adjusted screw slot depth for visibility
screw_diameter = 4;

// Function to create grooves
module cylinder_with_grooves() {
    difference() {
        cylinder(d = cylinder_diameter, h = cylinder_length, center = true);
        cylinder(d = hole_diameter, h = cylinder_length + 2, center = true);
        for (i = [0:num_grooves-1]) {
            translate([0, 0, cylinder_length/2 - groove_width*i - groove_width/2])
                cylinder(d = cylinder_diameter + 2, h = groove_depth, center = true);
        }
        for (pos = [-cylinder_diameter/3, cylinder_diameter/3]) { // Adjusted position of the slot cutouts
            rotate([90, 0, 0])
                translate([pos, 0, -screw_slot_depth])
                    cube([screw_slot_depth, screw_slot_width, screw_slot_width], center = true);
        }
    }
}

// Module for central pin shaft
module central_pin() {
    translate([-pin_length/2, 0, 0])
        rotate([0, 0, 0]) 
            cylinder(d = pin_diameter, h = pin_length, center = true);
}

// Module for adjustment slot with screws
module adjustment_screw() {
    translate([cylinder_length/4, 0, cylinder_diameter/2 + groove_depth - screw_slot_depth/2])
        rotate([0, 90, 0])
            cylinder(d = screw_diameter, h = screw_slot_depth, center = true);
    translate([-cylinder_length/4, 0, cylinder_diameter/2 + groove_depth - screw_slot_depth/2])
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
