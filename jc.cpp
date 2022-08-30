#include <fstream>
#include <nlohmann/json.hpp>

using json = nlohmann::json;
using namespace std;

int main(){
    map<string, vector<int>> mp;
    ifstream mi("mapping");
    ifstream js("subtasks.json");
    ofstream qj("config.json");
    json subs = json::parse(js), qu;
    string s;
    int x;
    while(mi>>s){
        mi >> x;
        mp[s].push_back(x);
    }
    qu["packages"] = json::array();
    for(auto it = subs["subtasks"].begin(); it != subs["subtasks"].end(); ++it){
        s = it.key();
        qu["packages"].push_back({ {"score", it.value()["score"]}, {"tests", mp[s]} });
    }
    qj << qu.dump(4);
    return 0;
}


