# What is the largest prime factor of the number 600851475143?

function all_factors(n)
    factors = []
    for i in 1:floor(Int, sqrt(n))
        if n % i == 0
            push!(factors, i)
            push!(factors, n / i)
        end
    end
    return factors
end

function is_prime_number(n)
    if n <= 1
        return false
    end
    limit = floor(Int, sqrt(n))
    for i in 2:limit
        if n % i == 0
            return false
        end
    end
    return true
end

largest_prime_factor = -1
factors = all_factors(600851475143)
for factor in factors
    if is_prime_number(factor) == true
        global largest_prime_factor = factor
    end
end
println(largest_prime_factor)