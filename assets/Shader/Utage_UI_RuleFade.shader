//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Utage/UI/RuleFade" {
Properties {
_RuleTex ("Rule", 2D) = "white" { }
_Strength ("Strength", Range(0, 1)) = 0.2
_Vague ("Vague", Range(0.001, 1)) = 0.2
_SrcBlend ("_src", Float) = 1
_DstBlend ("_dst", Float) = 0
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_SetColor ("Tint", Color) = (1,1,1,1)
_AddColor ("Tint", Color) = (0,0,0,0)
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend Zero Zero, Zero Zero
  ColorMask 0 0
  ZTest Off
  ZWrite Off
  Cull Off
  Stencil {
   ReadMask 0
   WriteMask 0
   Comp Disabled
   Pass Keep
   Fail Keep
   ZFail Keep
  }
  GpuProgramID 63096
Program "vp" {
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy;
    u_xlat0.zw = in_TEXCOORD1.xy;
    phase0_Output0_2 = u_xlat0;
    vs_TEXCOORD2 = in_POSITION0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _SetColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _Strength;
uniform 	mediump float _Vague;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _RuleTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_3 = texture(_RuleTex, vs_TEXCOORD1.xy).w;
    u_xlat3 = u_xlat16_3 + _TextureSampleAdd.w;
    u_xlat16_1 = float(1.0) / _Vague;
    u_xlat16_4 = u_xlat16_1 + -1.0;
    u_xlat16_4 = u_xlat3 * u_xlat16_4;
    u_xlat16_1 = (-u_xlat16_1) * _Strength + u_xlat16_4;
    u_xlat16_1 = u_xlat16_1 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 + _TextureSampleAdd;
    u_xlat16_1 = u_xlat16_1 * u_xlat2.w;
    SV_Target0.xyz = u_xlat2.xyz * _SetColor.xyz + _AddColor.xyz;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy;
    u_xlat0.zw = in_TEXCOORD1.xy;
    phase0_Output0_2 = u_xlat0;
    vs_TEXCOORD2 = in_POSITION0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _SetColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _Strength;
uniform 	mediump float _Vague;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _RuleTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_3 = texture(_RuleTex, vs_TEXCOORD1.xy).w;
    u_xlat3 = u_xlat16_3 + _TextureSampleAdd.w;
    u_xlat16_1 = float(1.0) / _Vague;
    u_xlat16_4 = u_xlat16_1 + -1.0;
    u_xlat16_4 = u_xlat3 * u_xlat16_4;
    u_xlat16_1 = (-u_xlat16_1) * _Strength + u_xlat16_4;
    u_xlat16_1 = u_xlat16_1 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 + _TextureSampleAdd;
    u_xlat16_1 = u_xlat16_1 * u_xlat2.w;
    SV_Target0.xyz = u_xlat2.xyz * _SetColor.xyz + _AddColor.xyz;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy;
    u_xlat0.zw = in_TEXCOORD1.xy;
    phase0_Output0_2 = u_xlat0;
    vs_TEXCOORD2 = in_POSITION0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _SetColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _Strength;
uniform 	mediump float _Vague;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _RuleTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_3;
mediump float u_xlat16_4;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_3 = texture(_RuleTex, vs_TEXCOORD1.xy).w;
    u_xlat3 = u_xlat16_3 + _TextureSampleAdd.w;
    u_xlat16_1 = float(1.0) / _Vague;
    u_xlat16_4 = u_xlat16_1 + -1.0;
    u_xlat16_4 = u_xlat3 * u_xlat16_4;
    u_xlat16_1 = (-u_xlat16_1) * _Strength + u_xlat16_4;
    u_xlat16_1 = u_xlat16_1 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 + _TextureSampleAdd;
    u_xlat16_1 = u_xlat16_1 * u_xlat2.w;
    SV_Target0.xyz = u_xlat2.xyz * _SetColor.xyz + _AddColor.xyz;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    SV_Target0.w = u_xlat0.x;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PREMULTIPLIED_ALPHA" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy;
    u_xlat0.zw = in_TEXCOORD1.xy;
    phase0_Output0_2 = u_xlat0;
    vs_TEXCOORD2 = in_POSITION0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _SetColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _Strength;
uniform 	mediump float _Vague;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _RuleTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_3 = texture(_RuleTex, vs_TEXCOORD1.xy).w;
    u_xlat3 = u_xlat16_3 + _TextureSampleAdd.w;
    u_xlat16_1.x = float(1.0) / _Vague;
    u_xlat16_4.x = u_xlat16_1.x + -1.0;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat16_1.x = (-u_xlat16_1.x) * _Strength + u_xlat16_4.x;
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 + _TextureSampleAdd;
    u_xlat16_4.x = (-u_xlat2.w) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * vs_COLOR0.w;
    u_xlat16_4.x = (-u_xlat16_4.x) * u_xlat16_1.x + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_4.x;
    SV_Target0.w = u_xlat0.x;
    u_xlat16_4.xyz = vs_COLOR0.www * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * _SetColor.xyz + _AddColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PREMULTIPLIED_ALPHA" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy;
    u_xlat0.zw = in_TEXCOORD1.xy;
    phase0_Output0_2 = u_xlat0;
    vs_TEXCOORD2 = in_POSITION0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _SetColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _Strength;
uniform 	mediump float _Vague;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _RuleTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_3 = texture(_RuleTex, vs_TEXCOORD1.xy).w;
    u_xlat3 = u_xlat16_3 + _TextureSampleAdd.w;
    u_xlat16_1.x = float(1.0) / _Vague;
    u_xlat16_4.x = u_xlat16_1.x + -1.0;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat16_1.x = (-u_xlat16_1.x) * _Strength + u_xlat16_4.x;
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 + _TextureSampleAdd;
    u_xlat16_4.x = (-u_xlat2.w) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * vs_COLOR0.w;
    u_xlat16_4.x = (-u_xlat16_4.x) * u_xlat16_1.x + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_4.x;
    SV_Target0.w = u_xlat0.x;
    u_xlat16_4.xyz = vs_COLOR0.www * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * _SetColor.xyz + _AddColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PREMULTIPLIED_ALPHA" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy;
    u_xlat0.zw = in_TEXCOORD1.xy;
    phase0_Output0_2 = u_xlat0;
    vs_TEXCOORD2 = in_POSITION0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _SetColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _Strength;
uniform 	mediump float _Vague;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _RuleTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_3 = texture(_RuleTex, vs_TEXCOORD1.xy).w;
    u_xlat3 = u_xlat16_3 + _TextureSampleAdd.w;
    u_xlat16_1.x = float(1.0) / _Vague;
    u_xlat16_4.x = u_xlat16_1.x + -1.0;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat16_1.x = (-u_xlat16_1.x) * _Strength + u_xlat16_4.x;
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 + _TextureSampleAdd;
    u_xlat16_4.x = (-u_xlat2.w) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * vs_COLOR0.w;
    u_xlat16_4.x = (-u_xlat16_4.x) * u_xlat16_1.x + 1.0;
    u_xlat0.x = u_xlat0.x * u_xlat16_4.x;
    SV_Target0.w = u_xlat0.x;
    u_xlat16_4.xyz = vs_COLOR0.www * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * _SetColor.xyz + _AddColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy;
    u_xlat0.zw = in_TEXCOORD1.xy;
    phase0_Output0_2 = u_xlat0;
    vs_TEXCOORD2 = in_POSITION0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _SetColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _Strength;
uniform 	mediump float _Vague;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _RuleTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
mediump float u_xlat16_1;
mediump float u_xlat16_3;
void main()
{
    u_xlat16_0.x = texture(_RuleTex, vs_TEXCOORD1.xy).w;
    u_xlat0.x = u_xlat16_0.x + _TextureSampleAdd.w;
    u_xlat16_1 = float(1.0) / _Vague;
    u_xlat16_3 = u_xlat16_1 + -1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat16_1 = (-u_xlat16_1) * _Strength + u_xlat16_3;
    u_xlat16_1 = u_xlat16_1 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_1 = u_xlat16_1 * u_xlat0.w;
    SV_Target0.xyz = u_xlat0.xyz * _SetColor.xyz + _AddColor.xyz;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_3 = u_xlat16_1 * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3<0.0);
#else
    u_xlatb0.x = u_xlat16_3<0.0;
#endif
    if(u_xlatb0.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy;
    u_xlat0.zw = in_TEXCOORD1.xy;
    phase0_Output0_2 = u_xlat0;
    vs_TEXCOORD2 = in_POSITION0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _SetColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _Strength;
uniform 	mediump float _Vague;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _RuleTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
mediump float u_xlat16_1;
mediump float u_xlat16_3;
void main()
{
    u_xlat16_0.x = texture(_RuleTex, vs_TEXCOORD1.xy).w;
    u_xlat0.x = u_xlat16_0.x + _TextureSampleAdd.w;
    u_xlat16_1 = float(1.0) / _Vague;
    u_xlat16_3 = u_xlat16_1 + -1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat16_1 = (-u_xlat16_1) * _Strength + u_xlat16_3;
    u_xlat16_1 = u_xlat16_1 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_1 = u_xlat16_1 * u_xlat0.w;
    SV_Target0.xyz = u_xlat0.xyz * _SetColor.xyz + _AddColor.xyz;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_3 = u_xlat16_1 * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3<0.0);
#else
    u_xlatb0.x = u_xlat16_3<0.0;
#endif
    if(u_xlatb0.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy;
    u_xlat0.zw = in_TEXCOORD1.xy;
    phase0_Output0_2 = u_xlat0;
    vs_TEXCOORD2 = in_POSITION0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _SetColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _Strength;
uniform 	mediump float _Vague;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _RuleTex;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bvec4 u_xlatb0;
mediump float u_xlat16_1;
mediump float u_xlat16_3;
void main()
{
    u_xlat16_0.x = texture(_RuleTex, vs_TEXCOORD1.xy).w;
    u_xlat0.x = u_xlat16_0.x + _TextureSampleAdd.w;
    u_xlat16_1 = float(1.0) / _Vague;
    u_xlat16_3 = u_xlat16_1 + -1.0;
    u_xlat16_3 = u_xlat0.x * u_xlat16_3;
    u_xlat16_1 = (-u_xlat16_1) * _Strength + u_xlat16_3;
    u_xlat16_1 = u_xlat16_1 + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 + _TextureSampleAdd;
    u_xlat16_1 = u_xlat16_1 * u_xlat0.w;
    SV_Target0.xyz = u_xlat0.xyz * _SetColor.xyz + _AddColor.xyz;
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_3 = u_xlat16_1 * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_1;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_3<0.0);
#else
    u_xlatb0.x = u_xlat16_3<0.0;
#endif
    if(u_xlatb0.x){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PREMULTIPLIED_ALPHA" "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy;
    u_xlat0.zw = in_TEXCOORD1.xy;
    phase0_Output0_2 = u_xlat0;
    vs_TEXCOORD2 = in_POSITION0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _SetColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _Strength;
uniform 	mediump float _Vague;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _RuleTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_7;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_3 = texture(_RuleTex, vs_TEXCOORD1.xy).w;
    u_xlat3 = u_xlat16_3 + _TextureSampleAdd.w;
    u_xlat16_1.x = float(1.0) / _Vague;
    u_xlat16_4.x = u_xlat16_1.x + -1.0;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat16_1.x = (-u_xlat16_1.x) * _Strength + u_xlat16_4.x;
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 + _TextureSampleAdd;
    u_xlat16_4.x = (-u_xlat2.w) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * vs_COLOR0.w;
    u_xlat16_4.x = (-u_xlat16_4.x) * u_xlat16_1.x + 1.0;
    u_xlat16_7 = u_xlat16_4.x * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_4.x;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_7<0.0);
#else
    u_xlatb0.x = u_xlat16_7<0.0;
#endif
    if(u_xlatb0.x){discard;}
    u_xlat16_4.xyz = vs_COLOR0.www * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * _SetColor.xyz + _AddColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PREMULTIPLIED_ALPHA" "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy;
    u_xlat0.zw = in_TEXCOORD1.xy;
    phase0_Output0_2 = u_xlat0;
    vs_TEXCOORD2 = in_POSITION0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _SetColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _Strength;
uniform 	mediump float _Vague;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _RuleTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_7;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_3 = texture(_RuleTex, vs_TEXCOORD1.xy).w;
    u_xlat3 = u_xlat16_3 + _TextureSampleAdd.w;
    u_xlat16_1.x = float(1.0) / _Vague;
    u_xlat16_4.x = u_xlat16_1.x + -1.0;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat16_1.x = (-u_xlat16_1.x) * _Strength + u_xlat16_4.x;
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 + _TextureSampleAdd;
    u_xlat16_4.x = (-u_xlat2.w) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * vs_COLOR0.w;
    u_xlat16_4.x = (-u_xlat16_4.x) * u_xlat16_1.x + 1.0;
    u_xlat16_7 = u_xlat16_4.x * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_4.x;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_7<0.0);
#else
    u_xlatb0.x = u_xlat16_7<0.0;
#endif
    if(u_xlatb0.x){discard;}
    u_xlat16_4.xyz = vs_COLOR0.www * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * _SetColor.xyz + _AddColor.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PREMULTIPLIED_ALPHA" "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
mediump  vec4 phase0_Output0_2;
out mediump vec2 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    u_xlat0.xy = in_TEXCOORD0.xy;
    u_xlat0.zw = in_TEXCOORD1.xy;
    phase0_Output0_2 = u_xlat0;
    vs_TEXCOORD2 = in_POSITION0;
vs_TEXCOORD0 = phase0_Output0_2.xy;
vs_TEXCOORD1 = phase0_Output0_2.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	mediump vec4 _SetColor;
uniform 	mediump vec4 _AddColor;
uniform 	mediump vec4 _TextureSampleAdd;
uniform 	vec4 _ClipRect;
uniform 	mediump float _Strength;
uniform 	mediump float _Vague;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _RuleTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
in mediump vec2 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
bvec4 u_xlatb0;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
mediump float u_xlat16_3;
mediump vec3 u_xlat16_4;
mediump float u_xlat16_7;
void main()
{
    u_xlatb0.xy = greaterThanEqual(vs_TEXCOORD2.xyxx, _ClipRect.xyxx).xy;
    u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, vs_TEXCOORD2.xxxy).zw;
    u_xlat0.x = u_xlatb0.x ? float(1.0) : 0.0;
    u_xlat0.y = u_xlatb0.y ? float(1.0) : 0.0;
    u_xlat0.z = u_xlatb0.z ? float(1.0) : 0.0;
    u_xlat0.w = u_xlatb0.w ? float(1.0) : 0.0;
;
    u_xlat0.xy = u_xlat0.zw * u_xlat0.xy;
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_3 = texture(_RuleTex, vs_TEXCOORD1.xy).w;
    u_xlat3 = u_xlat16_3 + _TextureSampleAdd.w;
    u_xlat16_1.x = float(1.0) / _Vague;
    u_xlat16_4.x = u_xlat16_1.x + -1.0;
    u_xlat16_4.x = u_xlat3 * u_xlat16_4.x;
    u_xlat16_1.x = (-u_xlat16_1.x) * _Strength + u_xlat16_4.x;
    u_xlat16_1.x = u_xlat16_1.x + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1.x = min(max(u_xlat16_1.x, 0.0), 1.0);
#else
    u_xlat16_1.x = clamp(u_xlat16_1.x, 0.0, 1.0);
#endif
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 + _TextureSampleAdd;
    u_xlat16_4.x = (-u_xlat2.w) + 1.0;
    u_xlat16_4.x = u_xlat16_4.x * vs_COLOR0.w;
    u_xlat16_4.x = (-u_xlat16_4.x) * u_xlat16_1.x + 1.0;
    u_xlat16_7 = u_xlat16_4.x * u_xlat0.x + -0.00100000005;
    u_xlat0.x = u_xlat0.x * u_xlat16_4.x;
    SV_Target0.w = u_xlat0.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0.x = !!(u_xlat16_7<0.0);
#else
    u_xlatb0.x = u_xlat16_7<0.0;
#endif
    if(u_xlatb0.x){discard;}
    u_xlat16_4.xyz = vs_COLOR0.www * vs_COLOR0.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
    u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * _SetColor.xyz + _AddColor.xyz;
    return;
}

#endif
"
}
}
}
}
}