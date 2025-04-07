
// Base block with a simple rectangular cut and holes
module base_block() {
    difference() {
        // Main block
        cube([40, 20, 10], center = true);
        
        // Cut-outs and holes
        translate([0, 0, 5])
            cylinder(r = 5, h = 20, center = true);
        translate([10, 8, 5])
            cylinder(r = 2, h = 12, center = true);
        translate([-10, 8, 5])
            cylinder(r = 2, h = 12, center = true);
    }
}

// Locking fasteners represented by simple cylinders with a hexagonal head
module locking_fastener() {
    union() {
        // Fastener body
        translate([0, 0, -5]) 
            cylinder(r = 1.5, h = 10, center = true);
        
        // Hexagonal head
        translate([0, 0, 5])
            rotate([0, 0, 30])
            cylinder(r = 3, h = 2, center = true, $fn=6);
    }
}

// Assembling the components
module assembly() {
    base_block();
    
    // Position fasteners at respective positions
    translate([10, 8, -5]) locking_fastener();
    translate([-10, 8, -5]) locking_fastener();
    translate([10, -8, -5]) locking_fastener();
    translate([-10, -8, -5]) locking_fastener();
}

assembly();

