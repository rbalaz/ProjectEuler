# How many, no necessarily distinct, value of (n r) are there such that 1 <= n <= 100 and 1 <= r <= n?

function combination(n, r)
    return factorial(big(n))/(factorial(big(r)) * factorial(big(n - r)))
end

over_million_count = 0
for n = 1:100
    for r=1:n
        value = combination(n, r)
        if value > 1_000_000
            global over_million_count += 1
        end
    end
end

println("The number of values of (n r) such that 1 <= n <= 100 and 1 <= r <= n with greater than one million is: ", over_million_count)