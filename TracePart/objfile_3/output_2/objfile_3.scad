
// Parameters
main_body_diameter = 30;
main_body_length = 50;
slot_width = 4;
slot_depth = 12;
slot_count = 8; // Adjusted slot count for more cutouts
thread_hole_diameter = 3.5; // Reduced diameter for threading accuracy
end_cap_diameter = main_body_diameter;
end_cap_thickness = 6; // Adjusted thickness for matching the original model
clamping_bolt_diameter = 4;
clamping_bolt_length = 25;
clamping_bolt_head_diameter = 7; // Adjust slightly for hexagonal head accuracy
clamping_bolt_head_height = 3;
side_hole_connector_diameter = main_body_diameter / 3;
side_hole_connector_length = 10;

// End Cap Module
module end_cap() {
    difference() {
        cylinder(d=end_cap_diameter, h=end_cap_thickness, $fn=100);
        translate([0, 0, -1])
            cylinder(d=thread_hole_diameter, h=end_cap_thickness + 2, $fn=60); // Center hole refinement
    }
}

// Main Body Module
module main_body() {
    difference() {
        cylinder(d=main_body_diameter, h=main_body_length, $fn=100);

        // Threaded holes for clamping bolts
        translate([main_body_diameter/4, 0, main_body_length/3])
            rotate([0, 90, 0])
            cylinder(d=thread_hole_diameter, h=main_body_diameter + 2, $fn=60);
        translate([-main_body_diameter/4, 0, main_body_length/1.5])
            rotate([0, 90, 0])
            cylinder(d=thread_hole_diameter, h=main_body_diameter + 2, $fn=60);

        // Side connector hole with detailed features
        translate([0, main_body_diameter/2, main_body_length/2])
            rotate([90, 0, 0])
            cylinder(d=side_hole_connector_diameter, h=side_hole_connector_length, $fn=60);

        // Internally corrected chamber dimensioning
        translate([0, 0, main_body_length/2])
            cylinder(d=main_body_diameter - 4, h=main_body_length, center=true, $fn=100);

        // Slots (evenly spaced and symmetrically aligned)
        for (i = [0 : slot_count - 1]) {
            angle = 360 / slot_count * i;
            rotate([0, 0, angle])
                translate([main_body_diameter/2 - 1, -slot_width/2, main_body_length/2])
                    cube([slot_depth, slot_width, main_body_length], center=true);
        }
    }
}

// Clamping Bolt Module
module clamping_bolt() {
    union() {
        // Shaft with refined threading
        cylinder(d=clamping_bolt_diameter, h=clamping_bolt_length, $fn=60);
        // Head with hexagonal adjustment
        translate([0, 0, clamping_bolt_length])
            cylinder(d=clamping_bolt_head_diameter, h=clamping_bolt_head_height, $fn=6);
    }
}

// Assembly
translate([0, 0, main_body_length + end_cap_thickness])
    end_cap();

main_body();

translate([main_body_diameter/4, 0, main_body_length/3])
    clamping_bolt();
translate([-main_body_diameter/4, 0, main_body_length/1.5])
    clamping_bolt();

translate([0, 0, -end_cap_thickness])
    end_cap();

