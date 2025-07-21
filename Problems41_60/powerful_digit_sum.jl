largest_sum = 0
for a in 1:99
    for b in 1:99
        n = BigInt(a)^BigInt(b)
        digit_sum = sum(digit -> parse(Int, digit), string(n))
        if digit_sum > largest_sum
            global largest_sum = digit_sum
        end
    end
end

println("Largest digit sum: $largest_sum")