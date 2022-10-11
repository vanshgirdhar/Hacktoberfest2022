#include <bits/stdc++.h>

using namespace std;

/*
    @return : vector of min distances to all nodes
    @param: mat -> graph adjacency matrix
    @param: src -> source node
*/
vector<int> dijsktra(vector<vector<int>>& mat, int src) {
    const int n = mat.size();

    vector<bool> visited(n, false);
    vector<int> dists(n, INT_MAX);

    dists[src] = 0; // distance to source is 0 
    set<pair<int, int>> pq; pq.insert({0, src});

    
    for(int j=0; j<n; j++) {
        pair<int, int> cur = *pq.begin();
        pq.erase(pq.begin());

        const int cost = cur.first;
        const int node = cur.second;

        if(visited[node]) continue;
        visited[node] = true;

        //Iterate every adjecent node and update their distance in pq
        for(int i=0; i<n; i++)  {
            if(mat[node][i] && (cost + mat[node][i]) < dists[i]) {
                dists[i] = cost + mat[node][i];
                pq.insert({dists[i], i});
            }
        }
    }

    return dists;
}
