// TRANSITION CODE BY NE_EO

#pragma header

uniform float apply;

void main()
{
	vec2 uv = openfl_TextureCoordv.xy;
	vec2 fragCoord = uv * openfl_TextureSize.xy;
	vec4 col = texture2D(bitmap, uv);

	vec2 uvf = fragCoord/openfl_TextureSize.xx;

	float dd = distance(uvf, vec2(0.5, openfl_TextureSize.y/openfl_TextureSize.x*0.5))*1.6666;

	if(dd > 1.0-apply)
		col.rgba = vec4(0.0, 0.0, 0.0, 1.0);

	gl_FragColor = col;
}