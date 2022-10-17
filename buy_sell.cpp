int maxProfit(vector<int>& prices) {
        int n=prices.size();  
        if(n<2)
        {
            return 0;
        }
        int minp=prices[0];
        int profit=-1e9;
        for(int i=1;i<n;i++)
        {
            minp=min(minp,prices[i]);
            profit=max(profit,prices[i]-minp);
        }
       
        return profit;
    }
