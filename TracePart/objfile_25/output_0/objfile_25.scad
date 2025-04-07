
// Parameters
cylinder_diameter = 30;
cylinder_length = 60;
slot_width = 5;
slot_depth = 3;
ring_thickness = 5;
bolt_diameter = 5;
bolt_length = 65;
nut_diameter = 8;
nut_thickness = 4;
cap_diameter = 30;
cap_thickness = 10;

// Central Cylinder
module central_cylinder() {
    difference() {
        cylinder(d = cylinder_diameter, h = cylinder_length, center = true);
        translate([0, 0, -cylinder_length/2])
            for (i = [0:3])
                rotate([0,0,90*i])
                    translate([-slot_depth+5, -slot_width/2, 10])
                        cube([cylinder_diameter, slot_width, cylinder_length], center = true);
    }
}

// Slotted Ring
module slotted_ring() {
    difference() {
        cylinder(d = cylinder_diameter + 2*ring_thickness, h = ring_thickness, center = true);
        cylinder(d = cylinder_diameter, h = ring_thickness + 1, center = true);
    }
}

// End Cap
module end_cap() {
    cylinder(d = cap_diameter, h = cap_thickness, center = true);
}

// Connecting Bolt
module connecting_bolt() {
    cylinder(d = bolt_diameter, h = bolt_length, center = true);
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
                translate([15 * i, 0, 0])
                    hexagonal_nut();
    }
}

// Render the assembly
assembly();

