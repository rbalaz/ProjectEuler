# Find largest prime pandigital number

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

function is_pandigital(number_string)
    for i=1:length(number_string)
        if !occursin(string(i), number_string)
            return false
        end
    end

    return true
end

largest_pandigital_prime = 0
for i=1:999999999
    if is_pandigital(string(i)) && is_prime(i) && i > largest_pandigital_prime
        global largest_pandigital_prime = i
    end
end

println("The largest pandigital prime is: ", largest_pandigital_prime)