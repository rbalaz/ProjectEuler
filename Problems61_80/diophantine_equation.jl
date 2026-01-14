# Find the value of D <= 1000 in minimal solutions of x in equation x^2 - Dy^2 = 1 for which the largest value of x is obtained.

function calculate_fractions_for_pell_equation(n)
    sqrt_n = isqrt(n)
    seen_states = Dict{Tuple{Int, Int}, Int}()
    
    m = 0
    d = 1
    a = sqrt_n
    step = 0
    
    continued_fractions = [a]
    period = 0
    while true
        m = d * a - m
        d = div(n - m * m, d)
        a = div(sqrt_n + m, d)
        
        state = (m, d)
        if haskey(seen_states, state)
            period = step - seen_states[state]
            if (period % 2 == 1)
                additional_period = continued_fractions[end-period + 1:end - 1]
                continued_fractions = vcat(continued_fractions, additional_period)
                return continued_fractions
            else
                return continued_fractions[1:end-1]
            end
        end
        
        continued_fractions = push!(continued_fractions, a)
        seen_states[state] = step
        step += 1
    end
end

function continued_fraction_value(fractions)
    numerator = BigInt(0)
    denominator = BigInt(0)
    for i in reverse(fractions)
        if denominator == 0
            denominator = BigInt(1)
            numerator = BigInt(i)
        else
            temp = denominator
            denominator = numerator
            numerator = temp + i * numerator
        end
    end

    return numerator
end

function diophantine_maximum_continued_fractions(limit)
    current_maximum = 0
    associated_D_value = 0
    for i=2:limit
        sqrt_i = sqrt(i)
        if sqrt_i == floor(sqrt_i)
            continue  # Skip perfect squares
        end

        # Solution via Pell's equation
        continued_fractions = calculate_fractions_for_pell_equation(i)
        current_x = continued_fraction_value(continued_fractions)
        
        if current_x > current_maximum
            current_maximum = current_x
            associated_D_value = i
        end
    end

    return current_maximum, associated_D_value
end

limit = 1000
result, associated_D = diophantine_maximum_continued_fractions(limit)
println("The maximum x for the limit of ", limit, " is: ", result)
println("The associated D value is: ", associated_D)