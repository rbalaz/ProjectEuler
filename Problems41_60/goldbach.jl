# What is the smallest odd composite that cannot be written as the sum of a prime and twice a square?

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

function find_factors(n)
    factors = []
    for i in 1:n
        if n % i == 0
            push!(factors, i)
        end
    end
    return factors
end

function goldbach_conjecture(n, prime_numbers)
    for prime in prime_numbers
        square = (n - prime) / 2
        if sqrt(square) == floor(sqrt(square))
            return true
        end
    end

    return false
end

current_number = 3
prime_numbers = [2]
while true
    if !(is_prime(current_number))
        if !(goldbach_conjecture(current_number, prime_numbers))
            break
        end
    else
        push!(prime_numbers, current_number)
    end

    global current_number += 2
end

println("The smallest odd composite that cannot be written as the sum of a prime and twice a square is: ", current_number)