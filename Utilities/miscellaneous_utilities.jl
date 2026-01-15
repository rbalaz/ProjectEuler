module MiscellaneousUtilities

export compute_totients, generate_pentagon_numbers, get_factors

function compute_totients(limit)
    phi = collect(1:limit)
    phi[1] = 1
    for i in 2:limit
        if phi[i] == i  # i is prime
            for j in i:i:limit
                phi[j] -= phi[j] ÷ i
            end
        end
    end
    return phi
end

function generate_pentagon_numbers(n)
    pentagon_numbers = []
    for i = 1:n
        pentagon_number = Int(i*(3*i - 1)/2)
        push!(pentagon_numbers, pentagon_number)
    end

    return pentagon_numbers
end

function get_factors(n)
    factors = []
    for i in 1:floor(Int, sqrt(n))
        if n % i == 0
            push!(factors, i)
            if i != n / i
                push!(factors, n / i)
            end
        end
    end
    return factors
end

end