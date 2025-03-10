# Find the sum of all primes below two million

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

function sum_of_primes(n)
    sum = 0
    for i in 2:n
        if is_prime_number(i) == true
            sum += i
        end
    end
    return sum
end

println(sum_of_primes(2000000))