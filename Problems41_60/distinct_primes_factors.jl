# Find the first four consecutive integers to have four distinct prime factors each

function find_factors(n)
    factors = []
    for i in 1:n
        if n % i == 0
            push!(factors, i)
        end
    end
    return factors
end

function is_prime(n)
    if n < 2
        return false
    end
    for i in 2:floor(Int, sqrt(n))
        if n % i == 0
            return false
        end
    end
    return true
end

function distinct_prime_factors(n)
    current_number = 1
    consecutive_count = 1
    while true
        factors = find_factors(current_number)
        prime_factors = []
        for factor in factors 
            if is_prime(factor)
                prime_factors = push!(prime_factors, factor)
            end
        end

        if length(prime_factors) == n
            global consecutive_count += 1
        else
            global consecutive_count = 0
        end

        if consecutive_count == n
            break
        end

        current_number += 1
    end

    return current_number - n + 1
end

first_number = distinct_prime_factors(2)
println("The first of the two consecutive integers to have two distinct prime factors is: ", first_number)
first_number = distinct_prime_factors(3)
println("The first of the three consecutive integers to have three distinct prime factors is: ", first_number)
first_number = distinct_prime_factors(4)
println("The first of the four consecutive integers to have four distinct prime factors is: ", first_number)