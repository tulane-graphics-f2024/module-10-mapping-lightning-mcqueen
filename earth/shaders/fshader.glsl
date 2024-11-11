#version 150

uniform vec4 ambient;
uniform vec4 LightPosition;

in vec4 pos;
in vec4 N;
in vec2 texCoord;

uniform mat4 ModelViewLight;

uniform sampler2D textureEarth;
uniform sampler2D textureNight;
uniform sampler2D textureCloud;
uniform sampler2D texturePerlin;

uniform float animate_time;


out vec4 fragColor;

void main()
{
  vec4 L = normalize( (ModelViewLight*LightPosition) - pos );
  float Kd = 1.0;
  
  vec4 diffuse_color = texture(textureEarth, texCoord );
  diffuse_color = Kd*diffuse_color;
  
  vec4 cloud_color = texture(textureCloud, texCoord);
  vec4 cloudBlend = diffuse_color + cloud_color * 0.5;
  cloudBlend = clamp(cloudBlend, 0.0, 1.0);
    
  fragColor = ambient + cloudBlend;
  fragColor = clamp(fragColor, 0.0, 1.0);
  fragColor.a = 1.0;
}

