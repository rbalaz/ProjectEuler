# Find the sum of all primes below two million

function sum_of_primes(n)
    sum = 0
    for i in 2:n
        if is_prime(i) == true
            sum += i
        end
    end
    return sum
end

include("../Utilities/primes_utilities.jl")
using .PrimeUtilities

println(sum_of_primes(2000000))