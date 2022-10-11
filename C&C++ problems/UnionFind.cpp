/*
    DSU: A data structure
    Often called "Union Find"
    make()  : Add a new node
    find()  : Finds parent of the group
    union() : merge set of a and set of b in single set
*/

#include <iostream>
#include <type_traits>

using namespace std;
const int N = 1e5 + 10;

class DSU
{
private:
    int parents[N]; // Points to element's parent node
public:
    int sizes[N];

    void make(int v)
    {
        parents[v] = v;
        sizes[v] = 1;
    }
    int find(int v)
    {
        if (parents[v] == v)
            return v;

        // Path compression
        return (parents[v] = find(parents[v]));
    }
    void makeUnion(int a, int b)
    { // Union by size
        a = find(a);
        b = find(b);
        if (sizes[a] > sizes[b])
            swap(a, b);
        parents[a] = b;
        sizes[b] += a;
    }
};

int main()
{
    cout << "\nDisjoint Set Union\n";

    DSU *uf = new DSU();
    uf->make(1);
    uf->make(2);
    uf->makeUnion(1, 2);

    cout << uf->sizes[10];

    return 0;
}
