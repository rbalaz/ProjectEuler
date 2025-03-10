# First triangular numbers to have over five hundred divisors

function get_factors(n)
    factors = []
    for i = 1:floor(Int, sqrt(n))
        if n % i == 0
            push!(factors, i)
            if i != n / i
                push!(factors, n / i)
            end
        end
    end
    return factors
end

i = 1
while true
    triangular_number = sum(1:i)
    factors = get_factors(triangular_number)
    if length(factors) > 500
        println(triangular_number)
        break
    end
    global i += 1
end