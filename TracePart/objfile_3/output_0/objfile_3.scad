
// Parameters (adjust dimensions based on images for accuracy)
main_body_diameter = 30; // Diameter of the main body
main_body_length = 50; // Length of the main body
slot_width = 5; // Width of each slot in the main body
slot_depth = 10; // Depth of each slot in the main body
thread_hole_diameter = 4; // Diameter of the threaded holes
end_cap_diameter = main_body_diameter; // Diameter of the end caps
end_cap_thickness = 5; // Thickness of the end caps
clamping_bolt_diameter = 4; // Diameter of clamping bolts
clamping_bolt_length = 20; // Length of clamping bolts
side_hole_connector_diameter = main_body_diameter / 3; // Diameter of side hole connector
side_hole_connector_length = 10; // Length of side hole connector

// Layer 1: Top end cap
module end_cap() {
    difference() {
        cylinder(d=end_cap_diameter, h=end_cap_thickness);
        translate([0, 0, -1]) cylinder(d=thread_hole_diameter, h=end_cap_thickness + 2);
    }
}
translate([0, 0, main_body_length + end_cap_thickness])
end_cap();

// Layer 2: Main Body with Side Hole Connector
module main_body() {
    difference() {
        cylinder(d=main_body_diameter, h=main_body_length);
        // Threaded holes for clamping bolts
        translate([main_body_diameter/4, 0, main_body_length/3]) rotate([0, 90, 0]) cylinder(d=thread_hole_diameter, h=main_body_diameter);
        translate([-main_body_diameter/4, 0, main_body_length/1.5]) rotate([0, 90, 0]) cylinder(d=thread_hole_diameter, h=main_body_diameter);

        // Side connector hole
        translate([0, main_body_diameter/2, main_body_length/2])
        rotate([90, 0, 0])
        cylinder(d=side_hole_connector_diameter, h=side_hole_connector_length);
        
        // Slots
        for(i = [0:3]) {
            rotate([0, i*90, 0]) translate([main_body_diameter/2, 0, main_body_length/2])
            cube([slot_width, slot_depth, main_body_length], center=true);
        }
    }
}
main_body();

// Layer 3: Clamping Bolts
module clamping_bolt() {
    union() {
        cylinder(d=clamping_bolt_diameter, h=clamping_bolt_length);
        translate([0, 0, clamping_bolt_length])
        cylinder(d=clamping_bolt_diameter * 2, h=clamping_bolt_diameter);
    }
}
translate([main_body_diameter/4, 0, main_body_length/3])
clamping_bolt();
translate([-main_body_diameter/4, 0, main_body_length/1.5])
clamping_bolt();

// Layer 4: Bottom end cap
translate([0, 0, -end_cap_thickness])
end_cap();

