
// Constants for dimensions (simplified for demonstration purposes)
shaft_length = 100;
shaft_diameter = 10;

grooved_cyl_length = 20;
grooved_cyl_diameter = 12;
groove_depth = 1;
groove_count = 5;

notched_ring_thickness = 5;
notched_ring_diameter = 16;
notch_width = 2;
notch_depth = 2;

bearing_interface_thickness = 3;
bearing_diameter = 14;

// Functions to create components
module shaft() {
    cylinder(h = shaft_length, d = shaft_diameter);
}

module grooved_cylinder() {
    difference() {
        cylinder(h = grooved_cyl_length, d = grooved_cyl_diameter);
        for(i = [0 : groove_count - 1]) {
            translate([0, 0, i * (grooved_cyl_length / groove_count)]) {
                cylinder(h = groove_depth, d = grooved_cyl_diameter + 2);
            }
        }
    }
}

module notched_ring() {
    difference() {
        cylinder(h = notched_ring_thickness, d = notched_ring_diameter);
        for(i = [0 : 360 : 360 / (360 / (notch_width * notch_depth))]) {
            rotate([0, 0, i]) {
                translate([notched_ring_diameter / 2 - notch_width, 0, 0])
                    cube([notch_width, notch_depth, notched_ring_thickness]);
            }
        }
    }
}

module bearing_interface() {
    cylinder(h = bearing_interface_thickness, d = bearing_diameter);
}

// Assemble model based on layers
module flexible_coupling() {

    // Layer 1
    translate([0, 0, shaft_length - bearing_interface_thickness])
        bearing_interface();

    // Layer 2
    translate([0, 0, shaft_length - bearing_interface_thickness - notched_ring_thickness])
        notched_ring();

    translate([0, 0, shaft_length - bearing_interface_thickness - notched_ring_thickness - grooved_cyl_length])
        grooved_cylinder();

    // Layer 3
    shaft();

    // Layer 4
    translate([0, 0, grooved_cyl_length])
        grooved_cylinder();

    translate([0, 0, grooved_cyl_length + notched_ring_thickness])
        notched_ring();

    // Layer 5
    bearing_interface();
}

// Render the flexible coupling
flexible_coupling();

