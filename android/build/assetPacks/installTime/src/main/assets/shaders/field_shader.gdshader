shader_type canvas_item;

uniform sampler2D dissolve_pattern;
uniform float dissolve_state : hint_range(0.0 ,1.01) = 0;
uniform float alpha_divider = 1;
uniform vec3 fill_color = vec3(255, 255, 255); 

void fragment() {
	COLOR = texture(TEXTURE, UV);
	float pattern_val = texture(dissolve_pattern, UV).r;
	COLOR.a *= step(dissolve_state, pattern_val);
	COLOR.a /= alpha_divider;
	COLOR.rgb = fill_color;
}
