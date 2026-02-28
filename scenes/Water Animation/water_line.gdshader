shader_type canvas_item;
uniform sampler2D screen_texture: hint_screen_texture;
uniform sampler2D noise_texture: filter_nearest, repeat_enable;

uniform vec2 speed = vec2(0.5, 0.2);
uniform float distortion = 0.01;

void vertex() {
	// Called for every vertex t
}


void fragment() {
	
	vec2 noise = 1.0 * texture(noise_texture, UV + (speed * TIME)).rg - vec2(1);
	
	COLOR = texture(TEXTURE, UV);
	
	COLOR *= texture(screen_texture, SCREEN_UV - (noise * distortion));
	
	COLOR *= vec4(2, 2, 2, 1);
}
