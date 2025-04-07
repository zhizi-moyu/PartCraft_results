// Define module for the cylindrical coupling body
module cylindrical_coupling_body() {
    difference() {
        // Main solid cylinder (adjusting height)
        cylinder(h=18, d=18, $fn=100);
        // Hollow center (ensuring alignment)
        translate([0, 0, -1]) 
        cylinder(h=20, d=10, $fn=100);
    }
}

// Define module for the flexible grooved segment
module flexible_grooved_segment() {
    difference() {
        // Main grooved cylinder
        cylinder(h=30, d=18, $fn=100);
        // Adjusting groove depth and spacing
        for (i = [5:5:25]) {
            translate([0, 0, i])
            cylinder(h=3, d=20, $fn=100); // Deeper grooves
        }
    }
}

// Define module for the internal gear interface
module internal_gear_interface() {
    difference() {
        // Outer solid disk
        cylinder(h=6, d=18, $fn=100);
        // Subtract inner hollow and sharpen gear teeth
        translate([0, 0, -1])
        cylinder(h=8, d=10, $fn=100);
        for (i = [0:60:300]) {
            rotate([0, 0, i])
            translate([6, 0, 1])
            cube([5, 2, 6], center=true); // Adjusted gear teeth size
        }
    }
}

// Define module for a hexagonal bolt
module hexagonal_bolt() {
    translate([0, 0, -6]) {
        union() {
            // Hexagonal head
            cylinder(h=3, d1=6, d2=6, $fn=6);
            // Bolt shaft (adjusting length for correct flush positioning)
            cylinder(h=10, d=2, $fn=100);
        }
    }
}

// Define module for a circular washer
module circular_washer() {
    difference() {
        // Outer washer disk (increased diameter for better force distribution)
        cylinder(h=1, d=8, $fn=100);
        // Inner ring hole
        translate([0, 0, -0.5])
        cylinder(h=2, d=3, $fn=100);
    }
}

// Assembly of the flexible coupling
module flexible_coupling() {
    // Cylindrical coupling body
    cylindrical_coupling_body();

    // Flexible grooved segment
    translate([0, 0, 18]) // Adjusted translation to match new height
    flexible_grooved_segment();

    // Internal gear interfaces
    translate([0, 0, -6])
    internal_gear_interface();
    translate([0, 0, 48]) // Adjusted translation to align with assembly
    internal_gear_interface();

    // Bolts and washers (4 placements around the perimeter)
    for (i = [0:90:270]) {
        rotate([0, 0, i]) {
            translate([10, 0, 5])
            hexagonal_bolt();
            translate([10, 0, -1.5])
            circular_washer();
        }
    }
}

// Call the assembly
flexible_coupling();
