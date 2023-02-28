#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

uniform float shift; //chromatic aberration
uniform bool scanlines; //scanlines
void mainImage()
{
    vec2 uv = fragCoord/iResolution.xy;

    vec4 col = texture(iChannel0, uv);
    float lum = min((0.3 * col.x + 0.6 * col.y + 0.1 * col.z) * 1.5, 1.0);

    // vignette
    float bri = 0.9 + (1.6 * uv.x * uv.y) * (1.0 - uv.x) * (1.0 - uv.y);
    // scanlines in darker areas
    if (scanlines == true)
	{
		bri *= 0.93 + 0.07 * lum + (abs(fract(uv.y * 90.0) - 0.5) - 0.25) * 0.28 * (1.0 - lum);
	}
	
    // chromatic aberration 
    col.x = bri * texture(iChannel0, vec2(uv.x + shift, uv.y)).x;
    col.y = bri * col.y;
    col.z = bri * texture(iChannel0, vec2(uv.x - shift, uv.y)).z;

    // Output to screen
    fragColor = col;
}