# Find the product of the coefficients, a and b for the quadratic expression that produces the maximum number of primes for consecutive values of n, starting with n = 0.

function is_prime(n)
    if n < 2
        return false
    end
    for i = 2:floor(Int, sqrt(n))
        if n % i == 0
            return false
        end
    end
    return true
end

maximum_number_of_primes = 0
product_of_coefficients = 0
for a = -999:999
    for b = -1000:1000
        n = 0
        while true
            value = n*n + a*n + b
            if is_prime(value) == false
                break
            end
            n += 1
        end
        if n > maximum_number_of_primes
            global maximum_number_of_primes = n
            global product_of_coefficients = a * b
        end
    end
end

println("The product of the coefficients, a and b for the quadratic expression that produces the maximum number of primes for consecutive values of n, starting with n = 0 is: ", product_of_coefficients)