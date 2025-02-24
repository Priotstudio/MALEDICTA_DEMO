shader_type spatial;

void vertex(){

}
uniform vec3 mainColor : source_color;

void fragment() {
	ALBEDO = mainColor;
}

void light () {
	float nDotL = clamp(dot (NORMAL, LIGHT), 0.0, 1.0);
	nDotL = smoothstep(0.01, 0.03, nDotL);

	// we add view direction with light direction
	vec3 addedCam = normalize(VIEW + LIGHT);
	// then calculate dot product with normals and clamp it
	float vDotL = clamp(dot(NORMAL, addedCam), 0.0, 1.0);
	// calculate the power of vdotl to create highlight sphere
	vDotL = pow(vDotL, 60);
	vDotL = smoothstep(0.06, 0.15, vDotL);

	float rimlight = clamp(dot(NORMAL, VIEW), 0.0, 1.0);
	rimlight = pow(1.0 -  rimlight, 12) * nDotL;
	rimlight = smoothstep(0.01, 0.02, rimlight);

	vec3 result = vec3(nDotL) + rimlight;
	DIFFUSE_LIGHT += result;
	// Assign specular light that we calculated
	SPECULAR_LIGHT += vDotL;
}