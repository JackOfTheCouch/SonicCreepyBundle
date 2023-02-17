#pragma header
        uniform float dis1;
        uniform float dis2;
        vec2 brownConradyDistortion(vec2 uv)
        {
            // positive values of K1 give barrel distortion, negative give pincushion
            float r2 = uv.x*uv.x + uv.y*uv.y;
            uv *= 1.0 + dis1 * r2 + dis2 * r2 * r2;
            
            // tangential distortion (due to off center lens elements)
            // is not modeled in this function, but if it was, the terms would go here
            return uv;
        }

        void main()
        {
            vec2 uv = openfl_TextureCoordv;
            uv -= .5;

            uv = brownConradyDistortion(uv);

            uv += .5;

            if(uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0){
                gl_FragColor = vec4(0.0);
                return;
            }
            
            gl_FragColor = flixel_texture2D(bitmap, uv);
        }