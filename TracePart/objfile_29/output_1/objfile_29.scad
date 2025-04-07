
// Base block with refined cut-outs and enlarged holes
module base_block() {
    difference() {
        // Main block
        cube([40, 20, 10], center = true);
        
        // Larger central cut-out with smoother edges
        translate([0, 0, 5])
            cylinder(r = 7, h = 20, center = true, $fn = 50);

        // Enlarged and realigned side holes
        translate([12, 8, 5])
            cylinder(r = 3, h = 12, center = true, $fn = 50);
        translate([-12, 8, 5])
            cylinder(r = 3, h = 12, center = true, $fn = 50);
    }
}

// Locking fasteners with refined dimensions and hexagonal head
module locking_fastener() {
    union() {
        // Thickened fastener body
        translate([0, 0, -5])
            cylinder(r = 2.5, h = 15, center = true, $fn = 50);

        // Sharpened hexagonal head
        translate([0, 0, 5])
            rotate([0, 0, 30])
            cylinder(r = 4, h = 2.5, center = true, $fn = 6);
    }
}

// Assembling the components
module assembly() {
    base_block();

    // Adjusted positioning and alignment of fasteners
    translate([12, 8, -5]) locking_fastener();
    translate([-12, 8, -5]) locking_fastener();
    translate([12, -8, -5]) locking_fastener();
    translate([-12, -8, -5]) locking_fastener();
}

assembly();

