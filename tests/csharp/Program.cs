using System;
using System.IO;
using System.Globalization;
using Hl1Bhop;
class Program {
    static int Main(string[] args) {
        if(args.Length!=1)return 2;
        int count=0;float largest=0;
        foreach(string line in File.ReadLines(args[0])) {
            if(line.StartsWith("name,") || String.IsNullOrWhiteSpace(line))continue;
            string[] c=line.Split(',');if(c.Length!=14)return 2;
            Func<int,float> n=i=>float.Parse(c[i],CultureInfo.InvariantCulture);
            Planar v=BhopMath.Step(new Planar(n(1),n(2)),new Planar(n(3),n(4)),n(5),n(6),n(7)!=0,n(8)!=0,n(9)!=0,n(10),n(11));
            float error=Math.Max(Math.Abs(v.X-n(12)),Math.Abs(v.Y-n(13)));
            largest=Math.Max(largest,error);
            if(error>.002f) { Console.Error.WriteLine(c[0]+": error "+error);return 1; }
            ++count;
        }
        Console.WriteLine("PASS C#: "+count+" fixtures, largest error "+largest+" GS units/s");
        return count>0 ? 0 : 2;
    }
}
