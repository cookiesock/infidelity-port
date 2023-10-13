#pragma header

uniform float dim = 1.8;
uniform float Directions = 16.0;
uniform float Quality = 8.0;
uniform float Size = 18.0;

void main(void)
{ 
    vec2 uv = openfl_TextureCoordv.xy ;

    float Pi = 6.28318530718;

    vec4 Color = texture2D( bitmap, uv);
    
    for(float d=0.0; d<Pi; d+=Pi/Directions){
        for(float i=1.0/Quality; i<=1.0; i+=1.0/Quality){

            float ex = (cos(d)*Size*i)/openfl_TextureSize.x;
            float why = (sin(d)*Size*i)/openfl_TextureSize.y;
            Color += flixel_texture2D( bitmap, uv+vec2(ex,why));	
        }
    }
    
    Color /= (dim * Quality) * Directions - 15.0;
    vec4 bloom =  (flixel_texture2D( bitmap, uv)/ dim)+Color;

    gl_FragColor = bloom;

}