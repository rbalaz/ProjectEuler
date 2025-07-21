function execute_root_convergence(numerator, denominator)
    if (numerator == 1 && denominator == 1)
        return (1, 2)
    else
        new_denominator = BigInt(2)*BigInt(denominator) + BigInt(numerator)
        new_numerator = BigInt(denominator)
    end

    return (new_numerator, new_denominator)
end


longer_numerator = 0
for i in 1:1000
    numerator = 1
    denominator = 1
    for j in 1:i
        (numerator, denominator) = execute_root_convergence(numerator, denominator)
    end

    final_numerator = denominator + numerator
    
    string_numerator = string(final_numerator)
    string_denominator = string(denominator)
    if length(string_numerator) > length(string_denominator)
        global longer_numerator += 1
    end
end

println("The number of times the numerator has more digits than the denominator in the first 1000 iterations is: ", longer_numerator)