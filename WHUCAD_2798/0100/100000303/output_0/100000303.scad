
// Base Frame
module base_frame() {
    difference() {
        // Main rectangular frame
        rounded_rectangle([80, 40], 5);
        // Slots for attachments
        translate([10, 15, 0]) rounded_rectangle([60, 10], 2);
        translate([10, 25, 0]) rounded_rectangle([60, 10], 2);
    }
}

// Side Support
module side_support() {
    difference() {
        // Triangular structure
        linear_extrude(height = 20) polygon(points = [[0, 0], [40, 0], [20, 20]]);
        // Ridge
        translate([18, 0, 10]) cube([4, 40, 10]);
    }
}

// Connector Frame
module connector_frame() {
    difference() {
        // Hollow rectangular frame
        rounded_rectangle([60, 30], 5);
        translate([5, 5, 0]) rounded_rectangle([50, 20], 2);
        // Thin bars for connection
        translate([5, 0, 0]) cube([5, 30, 5]);
        translate([50, 0, 0]) cube([5, 30, 5]);
    }
}

// Fastening Clips
module fastening_clips() {
    difference() {
        // Curved edge
        translate([0, 0, 0]) cylinder(r = 5, h = 10);
        // Hooks
        translate([-2, 2, 0]) cube([4, 6, 10]);
    }
}

// Utility function for rounded rectangle
module rounded_rectangle(size, radius) {
    hull() {
        translate([radius, radius]) circle(radius);
        translate([size[0] - radius, radius]) circle(radius);
        translate([radius, size[1] - radius]) circle(radius);
        translate([size[0] - radius, size[1] - radius]) circle(radius);
    }
}

// Assembly
module flexible_coupling() {
    // Layer 4: Base Frame
    translate([0, 0, 0]) base_frame();

    // Layer 3: Side Supports
    translate([-40, 0, 20]) side_support();
    translate([40, 0, 20]) mirror([1, 0, 0]) side_support();

    // Layer 2: Connector Frame
    translate([0, 0, 40]) connector_frame();

    // Layer 1: Fastening Clips
    translate([-30, 15, 50]) fastening_clips();
    translate([30, 15, 50]) fastening_clips();
    translate([-30, -15, 50]) fastening_clips();
    translate([30, -15, 50]) fastening_clips();
}

// Render the model
flexible_coupling();

