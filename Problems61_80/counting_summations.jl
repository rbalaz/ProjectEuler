function counting_summations(n)
    dp = zeros(Int, n+1)
    dp[1] = 1
    for i in 1:n-1
        for j in i+1:n+1
            dp[j] += dp[j-i]
        end
    end
    return dp[n+1]
end

limit = 100
combination_count = counting_summations(limit)
println("Number of partitions of $limit: $combination_count")