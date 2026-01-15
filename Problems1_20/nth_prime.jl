# Find the 10001st prime number.

include("../Utilities/primes_utilities.jl")
using .PrimeUtilities

number_of_primes = 0
current_prime = 1
while number_of_primes < 10001
    global current_prime += 1
    if is_prime(current_prime) == true
        global number_of_primes += 1
    end
end

println(current_prime)