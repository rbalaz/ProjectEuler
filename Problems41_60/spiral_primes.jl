# What is the side length of the square spiral for which the ratio of primes along both diagonals first falls below

function is_prime(n::Int)
    if n <= 1
        return false
    end
    for i in 2:floor(Int, sqrt(n))
        if n % i == 0
            return false
        end
    end
    return true
end


spiral_length = 3
prime_numbers = 0
non_prime_numbers = 0
while true
    for i=1:4
        value = spiral_length^2 - (i-1)*(spiral_length - 1)
        if is_prime(value)
            global prime_numbers += 1
        else
            global non_prime_numbers += 1
        end
    end

    ratio = prime_numbers / (prime_numbers + non_prime_numbers)
    if ratio <= 0.1
        println("Spiral side length: ", spiral_length)
        break
    end

    global spiral_length += 2
end