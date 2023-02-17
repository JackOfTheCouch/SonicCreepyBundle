#pragma header
#define PI 3.14159265
#define TILE_SIZE 16.0

float wow;
uniform float iTime;
vec2 iResolution = openfl_TextureSize;
uniform float Amount;

vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

vec3 posterize(vec3 color, float steps)
{
    return floor(color * steps) / steps;
}

float quantize(float n, float steps)
{
    return floor(n * steps) / steps;
}

vec4 downsample(sampler2D sampler, vec2 uv, float pixelSize)
{
    return flixel_texture2D(sampler, uv - mod(uv, vec2(pixelSize) / iResolution.xy));
}

float rand(float n)
{
    return fract(sin(n) * 43758.5453123);
}

float noise(float p)
{
    float fl = floor(p);
  	float fc = fract(p);
    return mix(rand(fl), rand(fl + 1.0), fc);
}

float rand(vec2 n) 
{ 
    return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}

float noise(vec2 p)
{
    vec2 ip = floor(p);
    vec2 u = fract(p);
    u = u * u * (3.0 - 2.0 * u);

    float res = mix(
        mix(rand(ip), rand(ip + vec2(1.0, 0.0)), u.x),
        mix(rand(ip + vec2(0.0,1.0)), rand(ip + vec2(1.0,1.0)), u.x), u.y);
    return res * res;
}

vec3 edge(sampler2D sampler, vec2 uv, float sampleSize)
{
    float dx = sampleSize / iResolution.x;
    float dy = sampleSize / iResolution.y;
    return (
    mix(downsample(sampler, uv - vec2(dx, 0.0), sampleSize), downsample(sampler, uv + vec2(dx, 0.0), sampleSize), mod(uv.x, dx) / dx) +
    mix(downsample(sampler, uv - vec2(0.0, dy), sampleSize), downsample(sampler, uv + vec2(0.0, dy), sampleSize), mod(uv.y, dy) / dy)    
    ).rgb / 2.0 - flixel_texture2D(sampler, uv).rgb;
}

vec4 distort(sampler2D sampler, vec2 uv, float edgeSize)
{
    vec2 pixel = vec2(1.0) / iResolution.xy;
    vec3 field = rgb2hsv(edge(sampler, uv, edgeSize));
    vec2 distort = pixel * sin((field.rb) * PI * 2.0);
    float shiftx = noise(vec2(quantize(uv.y + 31.5, iResolution.y / TILE_SIZE) * iTime, fract(iTime) * 300.0));
    float shifty = noise(vec2(quantize(uv.x + 11.5, iResolution.x / TILE_SIZE) * iTime, fract(iTime) * 100.0));
    vec4 col = flixel_texture2D(sampler, uv + (distort + (pixel - pixel / 2.0) * vec2(shiftx, shifty) * (50.0 + 100.0 * Amount)) * Amount);
    vec3 rgb = col.rgb;
    vec3 hsv = rgb2hsv(rgb);
    // hsv.y = mod(hsv.y + shifty * pow(Amount, 5.0) * 0.25, 1.0);
    return vec4(posterize(hsv2rgb(hsv), floor(mix(256.0, pow(1.0 - hsv.z - 0.5, 2.0) * 64.0 * shiftx + 4.0, 1.0 - pow(1.0 - Amount, 5.0)))), col.a);
}

void main()
{
	vec2 uv =  openfl_TextureCoordv;
    if(Amount <= 0){
        gl_FragColor = flixel_texture2D(bitmap, uv);
    }else{
        wow = clamp(mod(noise(iTime + uv.y), 1.0), 0.0, 1.0) * 2.0 - 1.0;    
        vec4 finalColor;
        finalColor += distort(bitmap, uv, 8.0);
        gl_FragColor = finalColor;
    }
}