using System;

namespace Hl1Bhop
{
    // Engine-independent scalar math, tested separately from Unity integration.
    public struct Planar
    {
        public float X, Y;
        public Planar(float x, float y) { X=x; Y=y; }
    }
    public static class BhopMath
    {
        static float Length(float x,float y) { return (float)Math.Sqrt(x*x+y*y); }
        public static Planar Step(Planar v,Planar wish,float dt,float maxspeed=300,
            bool grounded=false,bool jump=false,bool stock=true,float surface=1,float edge=1)
        {
            if (dt<=0) return v;
            float length=Length(wish.X,wish.Y), w=Math.Min(length,maxspeed);
            bool air=!grounded || jump;
            if (grounded && jump && stock)
            {
                float speed=Length(v.X,v.Y),limit=1.7f*maxspeed;
                if (limit>0 && speed>limit)
                { float fraction=limit/speed*.65f;v.X*=fraction;v.Y*=fraction; }
            }
            if (!air)
            {
                float speed=Length(v.X,v.Y);
                if (speed>=.1f)
                {
                    float drop=Math.Max(speed,100)*4*dt*surface*edge;
                    float fraction=Math.Max(speed-drop,0)/speed;
                    v.X*=fraction;v.Y*=fraction;
                }
            }
            if (length>0)
            {
                float dx=wish.X/length,dy=wish.Y/length;
                float cap=air ? Math.Min(w,30) : w;
                float add=cap-(v.X*dx+v.Y*dy);
                if (add>0)
                { float amount=Math.Min(add,10*w*dt*surface);v.X+=dx*amount;v.Y+=dy*amount; }
            }
            if (!air && Length(v.X,v.Y)<1) return new Planar(0,0);
            return v;
        }
    }
}
