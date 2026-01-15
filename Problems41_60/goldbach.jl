# What is the smallest odd composite that cannot be written as the sum of a prime and twice a square?

function goldbach_conjecture(n, prime_numbers)
    for prime in prime_numbers
        square = (n - prime) / 2
        if sqrt(square) == floor(sqrt(square))
            return true
        end
    end

    return false
end

include("../Utilities/primes_utilities.jl")
using .PrimeUtilities

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