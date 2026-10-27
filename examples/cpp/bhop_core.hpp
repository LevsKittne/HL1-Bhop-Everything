#pragma once
#include <algorithm>
#include <cmath>

namespace hl1_bhop {
struct Vec2 { float x=0, y=0; };
struct Settings {
    float accelerate=10, airaccelerate=10, friction=4, stopspeed=100, air_cap=30;
    bool stock_bunny_limit=true;
};
// All quantities are GoldSrc units. Jump means an accepted grounded takeoff.
// Planar limiting matches HL1's 3D check when pre-jump vertical velocity is zero.
inline Vec2 step(Vec2 v, Vec2 wish, float dt, float maxspeed=300,
                 bool grounded=false, bool jump=false, Settings s={},
                 float surface=1, float edge=1) {
    if (dt<=0) return v;
    const float length=std::hypot(wish.x,wish.y);
    const float w=std::min(length,maxspeed);
    const bool air=!grounded || jump;
    if (grounded && jump && s.stock_bunny_limit) {
        const float speed=std::hypot(v.x,v.y), limit=1.7f*maxspeed;
        if (limit>0 && speed>limit) {
            const float fraction=limit/speed*0.65f;
            v.x*=fraction; v.y*=fraction;
        }
    }
    if (!air) {
        const float speed=std::hypot(v.x,v.y);
        if (speed>=0.1f) {
            const float drop=std::max(speed,s.stopspeed)*s.friction*dt*surface*edge;
            const float fraction=std::max(speed-drop,0.0f)/speed;
            v.x*=fraction; v.y*=fraction;
        }
    }
    if (length>0) {
        const Vec2 d{wish.x/length,wish.y/length};
        const float cap=air ? std::min(w,s.air_cap) : w;
        const float add=cap-(v.x*d.x+v.y*d.y);
        if (add>0) {
            const float accel=air ? s.airaccelerate : s.accelerate;
            const float amount=std::min(add,accel*w*dt*surface);
            v.x+=d.x*amount; v.y+=d.y*amount;
        }
    }
    if (!air && std::hypot(v.x,v.y)<1) return {};
    return v;
}
}
