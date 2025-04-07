
// Define dimensions
central_shaft_length = 60;
central_shaft_diameter = 20;
end_cap_length = 10;
end_cap_diameter = 22;
end_cap_hole_diameter = 2;
spacer_ring_thickness = 2;
spacer_ring_diameter = 22;
mounting_hole_diameter = 4;

// Central Shaft
module central_shaft() {
    cylinder(h = central_shaft_length, d = central_shaft_diameter);
    // Grooves and steps can be added here
}

// End Cap
module end_cap() {
    difference() {
        cylinder(h = end_cap_length, d = end_cap_diameter);
        translate([0, 0, -1])
            cylinder(h = end_cap_length + 2, d = end_cap_hole_diameter);
        // Bolt holes
        for (angle = [0, 120, 240]) {
            rotate([0, 0, angle])
                translate([end_cap_diameter/3, 0, end_cap_length/2])
                    cylinder(h = end_cap_length + 2, d = mounting_hole_diameter);
        }
    }
}

// Spacer Ring
module spacer_ring() {
    difference() {
        cylinder(h = spacer_ring_thickness, d = spacer_ring_diameter);
        translate([0, 0, -1])
            cylinder(h = spacer_ring_thickness + 2, d = end_cap_diameter - 2);
    }
}

// Assembling the model
module flexible_coupling() {
    translate([0, 0, end_cap_length + spacer_ring_thickness])
        central_shaft();
    for (i = [0, 1]) {
        translate([0, 0, i * (central_shaft_length + end_cap_length)])
            end_cap();
        translate([0, 0, i * (central_shaft_length) + end_cap_length])
            spacer_ring();
    }
}

// Render the model
flexible_coupling();

