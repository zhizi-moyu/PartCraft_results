
// Parameters
$fn = 100; // Resolution for smooth circles

// Functions to generate components

// Circular Disk with Holes
module circular_disk_with_holes() {
    difference() {
        cylinder(h=10, r=40);
        cylinder(h=20, r=10); // Central hole
        for (angle = [0:45:360-45]) { // Spaced holes
            rotate([0,0,angle]) translate([30,0,0])
                cylinder(h=20, r=5);
        }
    }
}

// Cylinder with Flange
module cylinder_with_flange() {
    union() {
        // Flange base
        cylinder(h=10, r=40);
        // Cylinder above the flange
        translate([0,0,10]) cylinder(h=30, r=20);
        // Grooved section
        translate([0,0,12]) for (h = [12:6:30]) {
            cylinder(h=4, r=22);
        }
        // Central hollow
        translate([0,0,10]) cylinder(h=50, r=8);
        // Bolt holes on flange
        for (angle = [0:45:360-45]) {
            rotate([0,0,angle]) translate([30,0,5]) cylinder(h=20, r=2.5);
        }
    }
}

// Slotted Cylinder
module slotted_cylinder() {
    difference() {
        // Base cylinder
        translate([0,0,-5]) cylinder(h=40, r=20);
        // Slot along length
        rotate([90,0,0]) translate([-10,0,-25]) cube([40,10,50], center=false);
        // Larger hole at one end
        translate([0,0,35]) cylinder(h=10, r=25);
        // Central hollow
        translate([0,0,-5]) cylinder(h=50, r=8);
        // Bolt holes
        for (angle = [0:72:360-72]) {
            rotate([0,0,angle]) translate([22,0,35]) cylinder(h=20, r=2.5);
        }
    }
}

// Assembly of Components
module flexible_coupling() {
    // Layer 1: Circular disk
    circular_disk_with_holes();

    // Layer 2: Cylinder and Slotted Cylinder
    translate([0,0,-10]) cylinder_with_flange();
    translate([0,0,-25]) slotted_cylinder();
}

// Call the main assembly module
flexible_coupling();

