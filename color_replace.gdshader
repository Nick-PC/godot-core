shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

uniform bool use_entire_screen;
uniform float color_depth;

const int number_of_colors = 5;
uniform vec4 OLD_COLORS[number_of_colors]: source_color;
uniform vec4 NEW_COLORS[number_of_colors]: source_color;

vec4 truncate_vector(vec4 v, float n) {
    v.x=floor(pow(10,n) * v.x) / pow(10,n);
    v.y=floor(pow(10,n) * v.y) / pow(10,n);
    v.z=floor(pow(10,n) * v.z) / pow(10,n);
	v.a=floor(pow(10,n) * v.a) / pow(10,n);
	
    return v;
}

bool vector_equals(vec4 v1, vec4 v2) {
	return v1.x == v2.x
		&& v1.y == v2.y
		&& v1.z == v2.z
		&& v1.a == v2.a;
}

bool is_same_color(vec4 v1, vec4 v2) {
	return vector_equals(truncate_vector(v1, color_depth),truncate_vector(v2, color_depth));
}

void fragment() {
	vec4 curr_color;
	
	if (use_entire_screen) {
		curr_color = texture(screen_texture, SCREEN_UV);
	}
	else {
		curr_color = texture(TEXTURE, UV);
	}
	
	bool replaced_color = false;
	
	for (int i=0; i<number_of_colors; i++) {
		if (is_same_color(curr_color, OLD_COLORS[i])) {
			COLOR = NEW_COLORS[i];
			replaced_color = true;
			break;
		}
	}
	
	if (!replaced_color) {
		COLOR = curr_color;
	}
}