#include "../examples/cpp/bhop_core.hpp"
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>
int main(int argc,char** argv) {
    if(argc!=2) { std::cerr<<"Usage: test_core cases.csv\n"; return 2; }
    std::ifstream f(argv[1]);if(!f) return 2;
    std::string line;std::getline(f,line);int count=0;float largest=0;
    while(std::getline(f,line)) {
        if(line.empty())continue;
        std::vector<std::string> c;std::stringstream row(line);std::string value;
        while(std::getline(row,value,','))c.push_back(value);
        if(c.size()!=14) return 2;
        auto n=[&](int i){return std::stof(c[i]);};
        hl1_bhop::Settings s;s.stock_bunny_limit=n(9)!=0;
        auto v=hl1_bhop::step({n(1),n(2)},{n(3),n(4)},n(5),n(6),n(7)!=0,n(8)!=0,s,n(10),n(11));
        float error=std::max(std::abs(v.x-n(12)),std::abs(v.y-n(13)));
        largest=std::max(largest,error);
        if(error>0.002f) { std::cerr<<c[0]<<": error "<<error<<"\n";return 1; }
        ++count;
    }
    std::cout<<"PASS C++: "<<count<<" fixtures, largest error "<<largest<<" GS units/s\n";
    return count ? 0 : 2;
}
