# Calculate the sum of the digits of the number of 2^1000.

function calculate_power_digit_sum(n, power)
    power_value = BigInt(n)^power
    return sum(digits(power_value))
end

println("Sum of digits of 2^1000 is: " * string(calculate_power_digit_sum(2, 1000)))