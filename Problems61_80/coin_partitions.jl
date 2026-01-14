# Find the least value of n for which the number of different ways in which n can be written as a sum of positive integers is divisible by one million.

limit = 100_000  # Arbitrary large limit to ensure we find the answer
# Pentagonal theorem based partition function
p = zeros(BigInt, limit+1)
p[1] = 1 
n = 1
while true
    total = BigInt(0)
    k = 1
    while true
        pent1 = k * (3k - 1) ÷ 2
        pent2 = k * (3k + 1) ÷ 2
        if pent1 > n && pent2 > n
            break
        end
        sign = (-1)^(k+1)
        if pent1 <= n
            total += sign * p[n - pent1 + 1]
        end
        if pent2 <= n
            total += sign * p[n - pent2 + 1]
        end
        k += 1
    end
    p[n+1] = total
    if p[n+1] % 1_000_000 == 0
        break
    end
    global n += 1
end

println("Smallest n, where p(n) is divisible by one million: $n")
println("Actual value of p(n): $(p[n+1])")