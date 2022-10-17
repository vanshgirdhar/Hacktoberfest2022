class Solution
{
    public:
    vector<int> printCousins(Node* root, Node* node_to_find)
    {
        //code here
        vector<int>ans;

        queue<Node *>q;
        q.push(root);
        if(root==NULL)
        {
            return ans;
        }

        bool found=false;
        while(!q.empty()&&!found)
        {
            int size=q.size();
            for(int i=0;i<size;i++)
            {
            Node *temp=q.front();
            q.pop();

            if ((temp->left == node_to_find ||
                temp->right == node_to_find)) {
                found = true;
            }
            else
            {

            if(temp->left!=NULL)
            {
                q.push(temp->left);
            }
            if(temp->right!=NULL)
            {
                q.push(temp->right);
            }
            }


    }
        }
      int size_ = q.size();
       if(size_==0)
      return {-1};
      Node *p;
        if (found) {
        for (int i = 0; i < size_; i++) {
            p = q.front();
            q.pop();
            ans.push_back(p->data);
        }
    }
    else {
        ans.clear();
        ans.push_back(-1);
    }
    return ans;
}

};
