# Find the 10001st prime number.

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

number_of_primes = 0
current_prime = 1
while number_of_primes < 10001
    global current_prime += 1
    if is_prime_number(current_prime) == true
        global number_of_primes += 1
    end
end

println(current_prime)