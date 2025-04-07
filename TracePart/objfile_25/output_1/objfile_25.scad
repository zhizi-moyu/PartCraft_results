// Parameters
cylinder_diameter = 30;
cylinder_length = 60;
slot_width = 5;
slot_depth = 4; // Deepened the slot for more prominent grooves
ring_thickness = 3; // Thinner rings for proper alignment
bolt_diameter = 5;
bolt_length = 65;
nut_diameter = 7; // Smaller nuts for compact shape
nut_thickness = 3; // Reduced thickness for precision
cap_diameter = 30;
cap_thickness = 6; // Thinner end caps with slight inward curvature

// Central Cylinder
module central_cylinder() {
    difference() {
        cylinder(d = cylinder_diameter, h = cylinder_length, center = true);
        translate([0, 0, -cylinder_length/2])
            for (i = [0:3])
                rotate([0,0,90*i])
                    translate([-slot_depth+4, -slot_width/2, 10])
                        cube([cylinder_diameter, slot_width, cylinder_length], center = true);
    }
}

// Slotted Ring
module slotted_ring() {
    difference() {
        cylinder(d = cylinder_diameter + 2*ring_thickness, h = ring_thickness, center = true);
        for (i = [0:3])
            rotate([0, 0, 90*i])
                translate([-slot_depth+6, -slot_width/2, 0])
                    cube([cylinder_diameter, slot_width, ring_thickness], center = true);
    }
}

// End Cap
module end_cap() {
    cylinder(d = cap_diameter, h = cap_thickness, center = true);
    translate([0, 0, cap_thickness/2])
        cylinder(d = cap_diameter - 2, h = cap_thickness/4, center = true); // Inward curvature
}

// Connecting Bolt
module connecting_bolt() {
    translate([0, 0, -bolt_length/2])
        cylinder(d = bolt_diameter, h = bolt_length, center = true);
    translate([0, 0, bolt_length/2 + 2])
        cylinder(d = bolt_diameter+1, h = 2, center = true); // Defined bolt head
}

// Hexagonal Nut
module hexagonal_nut() {
    cylinder(d = nut_diameter, h = nut_thickness, center = true, $fn=6);
}

// Assembly
module assembly() {
    union() {
        central_cylinder();
        translate([0, 0, -cylinder_length/2 - ring_thickness/2])
            slotted_ring();
        translate([0, 0, cylinder_length/2 + ring_thickness/2])
            slotted_ring();
        translate([0, 0, -cylinder_length/2 - cap_thickness/2 - ring_thickness])
            end_cap();
        translate([0, 0, cylinder_length/2 + cap_thickness/2 + ring_thickness])
            end_cap();
        translate([0, 0, -cylinder_length/2 - bolt_length/2])
            connecting_bolt();
        translate([0, 0, cylinder_length/2 + bolt_length/2])
            connecting_bolt();
        translate([0, 0, -cylinder_length/2])
            for (i = [-1, 1])
                translate([13 * i, 0, 0]) // Adjusted positioning
                    hexagonal_nut();
    }
}

// Render the assembly
assembly();
