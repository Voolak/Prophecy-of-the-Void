shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float progression : hint_range(0.0, 1.0) = 0.5;

uniform float fade : hint_range(0.0, 1.0) = 0.9;

uniform float thickness : hint_range(0.01, 1.0) = 0.1;

uniform float wavelet_factor : hint_range(.1, 4.) = 4.;

// In pixels.
uniform float deformation_length = 16;

uniform vec2 screen_pos;

uniform vec2 screen_size;

uniform vec4 tint : source_color = vec4(.5, .5, .9, 1.);

void fragment() {
	vec2 norm = normalize(UV - vec2(.5));
	float dist = distance(UV, vec2(.5)) * 2.;
	float prog = progression * (1. - thickness - 0.01);
	float distortion = clamp((dist - prog) / thickness, -1., 1.);
	distortion = mix(cos(distortion * (PI / wavelet_factor)), 0., step(0.99, abs(distortion)));
	vec2 def = distortion * deformation_length * SCREEN_PIXEL_SIZE;
	vec2 offset_vector = norm * def;
	vec2 target_id = screen_pos + ((UV + offset_vector) * screen_size);
	target_id.y = 1.0 - target_id.y;
	COLOR = mix(vec4(0.),
				vec4(texture(SCREEN_TEXTURE, target_id).rgb, mix(1.0, smoothstep(1., 0., (progression - fade) / (1. - fade)),
				step( fade, progression ))), step(0.01, distortion));
}