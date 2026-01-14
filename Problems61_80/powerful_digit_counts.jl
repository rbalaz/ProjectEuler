# How many n-digit positive integers exist which are also an n-th power?

powerful_numbers = [BigInt(1)]
for i=2:9
    exponent = 1
    while true
        value = BigInt(i)^exponent
        digit_count = length(digits(value))
        if digit_count == exponent
            push!(powerful_numbers, value)
        elseif digit_count < exponent
            break # Once the digit count is less than the exponent, we can stop checking higher exponents
        end
        exponent += 1
    end
end

println("Powerful numbers found: ", powerful_numbers)
println("Total powerful numbers found: ", length(powerful_numbers))