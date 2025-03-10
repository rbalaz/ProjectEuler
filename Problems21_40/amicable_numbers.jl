# Evaluate the sum of all the amicable numbers under 10000.
function get_factors(n)
    factors = []
    for i in 1:floor(Int, sqrt(n))
        if n % i == 0
            push!(factors, i)
            if i != n / i
                push!(factors, n / i)
            end
        end
    end
    return factors
end

function is_amicable(n)
    factors_n = get_factors(n)
    amicable_candidate = sum(factors_n) - n
    if amicable_candidate <= 0
        return false
    end
    amicable_factors = get_factors(amicable_candidate)
    amicable_factors_sum = sum(amicable_factors) - amicable_candidate
    return amicable_factors_sum == n && amicable_candidate != n
end

function sum_of_amicable_numbers(n)
    amicable_sum = 0
    for i = 1:n - 1
        if is_amicable(i)
            println("Found amicable number: " * string(i))
            amicable_sum += i
        end
    end
    return amicable_sum
end

println("Sum of amicable numbers below 10000: " * string(sum_of_amicable_numbers(10000)))