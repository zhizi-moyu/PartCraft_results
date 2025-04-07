
// Module for the coupling shell
module coupling_shell() {
    difference() {
        // Main cylindrical body
        cylinder(h = 30, d = 20, center = true);
        
        // Slit in the middle
        translate([-12, 0, -15])
            cube([24, 2, 30], center = true);
        
        // Bolt holes
        translate([0, 0, -7.5])
            cylinder(h = 30, d = 5, center = true);
    }
}

// Module for a bolt
module bolt() {
    union() {
        // Main bolt shaft
        cylinder(h = 20, d = 5, center = true);
        // Bolt head
        translate([0, 0, 10])
            cylinder(h = 4, d = 8, center = true);
    }
}

// Module for a nut
module nut() {
    union() {
        // Hexagonal shape for nut
        translate([0, 0, -3])
            cylinder(h = 6, d = 8, center = true, $fn = 6);
        
        // Internal threaded hole (approximation)
        translate([0, 0, -3])
            cylinder(h = 6, d = 5, center = true);
    }
}

// Build the full coupling with nuts and bolts
module flexible_coupling() {
    // Coupling shell with a slit
    union() {
        coupling_shell();
        
        // Translating the bolts to the right positions
        translate([0, 0, 0])
            bolt();
        
        translate([0, 0, 15])
            bolt();
        
        // Corresponding nuts
        translate([0, 0, -18])
            nut();
        
        translate([0, 0, -3])
            nut();
    }
}

flexible_coupling();

