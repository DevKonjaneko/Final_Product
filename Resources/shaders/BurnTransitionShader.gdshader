shader_type canvas_item;

uniform sampler2D noise_texture: hint_default_black, repeat_enable;
uniform float burn_amount: hint_range(0.0, 1.0, 0.1) = 0.0;
uniform vec3 burn_color: source_color = vec3(0.8, 0.4, 0.2);
uniform float dist_edge: hint_range(0.0, 1.0, 0.01) = 0.05;
uniform float warp_factor: hint_range(0.0, 1.0, 0.01) = 0.3;

void fragment(){
	vec2 uv = UV;
	float burn_pixel = ((texture(noise_texture, uv).r - 0.5) + 2.0 * uv.x) / 3.0 + 0.15;
	float mask = smoothstep(burn_amount - 0.1, burn_amount, burn_pixel);
	float distortion = smoothstep(burn_amount - 0.2, burn_amount + dist_edge, burn_pixel);
	float transition = pow(distortion, 10.0);
	float warp = 1.0 - warp_factor + pow(distortion, 2.0) * warp_factor;
	vec3 color = texture(TEXTURE, uv * warp).rgb;
	COLOR = vec4(mix(color * burn_color, color, burn_amount) * mask, 1.0);
}
