
// Base Frame
module base_frame() {
    difference() {
        union() {
            translate([0, 0, 0]) cube([80, 20, 2]); // Main frame
            translate([0, 0, 0]) cube([2, 18, 10]); // Elongated legs
            translate([78, 0, 0]) cube([2, 18, 10]);
        }
        translate([8, 4, 0.1]) cube([64, 12, 2.1]); // Cut-out windows
    }
}

// Support Wedge
module support_wedge() {
    difference() {
        translate([0, 0, 0]) {
            cube([10, 30, 10], true); // Base
            translate([0, 0, 5]) rotate([0, -45, 0]) cube([10, 30, 10], true); // Sloped surface
        }
        translate([-3, 0, 10.1]) cube([6, 6, 2.1]); // Hollow connecting slot
    }
}

// Inner Bracket
module inner_bracket() {
    difference() {
        union() {
            translate([5, 5, 0]) cube([70, 20, 2]); // Flat piece
            translate([10, 9, 0.1]) cube([60, 14, 2.1]); // Central cutout
        }
    }
}

// Assembly
module assembly() {
    // Base Frame at the bottom
    translate([0, 0, 0]) base_frame();

    // Support Wedges layer above base frame
    translate([15, -5, 2]) support_wedge(); // Left wedge
    translate([65, -5, 2]) support_wedge(); // Right wedge

    // Inner Bracket at the top
    translate([0, 0, 12]) inner_bracket();
}

// Render the assembly
assembly();

