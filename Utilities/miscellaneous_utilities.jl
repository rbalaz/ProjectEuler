module MiscellaneousUtilities

export compute_totients, generate_pentagon_numbers, get_factors, get_key_with_minimum_value

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
            if i != n ÷ i
                push!(factors, n ÷ i)
            end
        end
    end
    return factors
end

function get_key_with_minimum_value(dictionary)
  min_key = nothing
  min_value = typemax(Int)
  for (key, value) in dictionary
    if value < min_value
      min_key = key
      min_value = value
    end
  end
  return min_key
end

end