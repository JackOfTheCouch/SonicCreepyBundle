 #pragma header
    //inputs
    uniform float AMT; //0 - 1 glitch amount
    uniform float SPEED; //0 - 1 speed
    uniform float iTime;
    //2D (returns 0 - 1)
float random2d(vec2 n) { 
    return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}

float randomRange (in vec2 seed, in float min, in float max) {
		return min + random2d(seed) * (max - min);
}

// return 1 if v inside 1d range
float insideRange(float v, float bottom, float top) {
   return step(bottom, v) - step(top, v);
}


   
void main()
{
    
    float time = floor(iTime * SPEED * 60.0);    
	vec2 uv = openfl_TextureCoordv;
    
    //copy orig
    vec4 outCol = flixel_texture2D(bitmap, uv);
    
    //randomly offset slices horizontally
    float maxOffset = AMT/2.0;
    for (float i = 0.0; i < 10.0 * AMT; i += 1.0) {
        float sliceY = random2d(vec2(time , 2345.0 + float(i)));
        float sliceH = random2d(vec2(time , 9035.0 + float(i))) * 0.25;
        float hOffset = randomRange(vec2(time , 9625.0 + float(i)), -maxOffset, maxOffset);
        vec2 uvOff = uv;
        uvOff.x += hOffset;
        if (insideRange(uv.y, sliceY, fract(sliceY+sliceH)) == 1.0 ){
        	outCol = flixel_texture2D(bitmap, uvOff);
        }
    }
    
    //do slight offset on one entire channel
    float maxColOffset = AMT/6.0;
    float rnd = random2d(vec2(time , 9545.0));
    vec2 colOffset = vec2(randomRange(vec2(time , 9545.0),-maxColOffset,maxColOffset), 
                       randomRange(vec2(time , 7205.0),-maxColOffset,maxColOffset));
    if (rnd < 0.33){
        outCol.r = flixel_texture2D(bitmap, uv + colOffset).r;
        
    }else if (rnd < 0.66){
        outCol.g = flixel_texture2D(bitmap, uv + colOffset).g;
        
    } else{
        outCol.b = flixel_texture2D(bitmap, uv + colOffset).b;  
    }
       
	gl_FragColor = outCol;
}