# What is the largest prime factor of the number 600851475143?

include("../Utilities/miscellaneous_utilities.jl")
using .MiscellaneousUtilities
include("../Utilities/primes_utilities.jl")
using .PrimeUtilities

largest_prime_factor = -1
factors = get_factors(600851475143)
for factor in factors
    if is_prime(factor) == true
        global largest_prime_factor = factor
    end
end
println(largest_prime_factor)