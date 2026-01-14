# How many digit factorial chains, with a starting number below one million, 
# contain exactly sixty non-repeating terms?

function generate_digit_factorial_chain(value)
    chain = []
    current_value = value
    while !(current_value in chain)
        push!(chain, current_value)
        digits = map(x -> parse(Int, x), collect(string(current_value)))
        current_value = sum(factorial(d) for d in digits)
    end
    
    return length(chain)
end

limit = 1_000_000
count_60_chains = 0
for i in 1:limit-1
    chain_length = generate_digit_factorial_chain(i)
    if chain_length == 60
        global count_60_chains += 1
    end
end

println("Number of chains with exactly 60 non-repeating terms for starting values below $limit is $count_60_chains")