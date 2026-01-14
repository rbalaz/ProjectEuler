# Find how many continued fractions for square roots of integers up to 1000 have an odd period length

function calculate_continued_fraction_period_length_fast(n)
    # Check if it's a perfect square first
    sqrt_n = isqrt(n)
    if sqrt_n * sqrt_n == n
        return 0
    end
    
    seen_states = Dict{Tuple{Int, Int}, Int}()
    
    m = 0
    d = 1
    a = sqrt_n
    step = 0
    
    while true
        m = d * a - m
        d = div(n - m * m, d)
        a = div(sqrt_n + m, d)
        
        state = (m, d)
        if haskey(seen_states, state)
            return step - seen_states[state]
        end
        
        seen_states[state] = step
        step += 1
    end
end


odd_period_count = 0
for i=1:10000
    continued_fraction_period_length = calculate_continued_fraction_period_length_fast(i)
    if continued_fraction_period_length % 2 == 1
        global odd_period_count += 1
    end
end

println("Number of odd period continued fractions for square roots of integers up to 10000: ", odd_period_count)