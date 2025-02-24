shader_type canvas_item;



void fragment() {
	// Called for every pixel the material is visible on.
	vec2 uv_centered = UV - vec2(0.5);
	float dist = length(uv_centered);
	
	if (dist > 0.5){
		discard;
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
