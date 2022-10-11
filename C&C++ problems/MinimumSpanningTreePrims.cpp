#include<iostream>
#include<vector>
#include<set>
#include<unordered_set>

using namespace std;

int prims(vector<vector<pair<int, int>>>& adj) {

    int totalWeight = 0;
    set<pair<int, int>> pq;

    long seenCnt = 1;
    vector<bool> seen(adj.size(), false);

    seen[0] = true;
    for(auto p : adj[0]) {
        pq.insert({p.second, p.first});
    }


    while(seenCnt < adj.size() || pq.size()) {

        auto cad = *pq.begin();
        pq.erase(pq.begin());

        const int weight = cad.first;
        const int v1 = cad.second;

        if(seen[v1]) continue;
        seen[v1] = true;

        seenCnt++;
        totalWeight += weight;

        for(auto p : adj[v1]) {
            pq.insert({p.second, p.first});
        }

    }

    return totalWeight;
}
