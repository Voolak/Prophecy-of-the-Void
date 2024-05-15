shader_type canvas_item;

uniform vec4 bubble_color: source_color = vec4(1.0);
uniform float bubble_radius: hint_range(0.1, 1) = 0.1;
uniform float bubble_intensity: hint_range(0.1, 1.0) = 1.0;

void fragment() {
	if (pow(UV.x-0.5, 2)+ pow(UV.y-0.5, 2) < bubble_radius) {
		COLOR = bubble_color;
		COLOR.a = pow(UV.x-0.5, 2)+ pow(UV.y-0.5, 2);
	} else {
		COLOR = vec4(0.0);
	}
}