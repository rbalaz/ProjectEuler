function heron_approximation(S)
    approximation = Int(ceil(sqrt(S))) # Initial guess
    # Exact operations with fractions required to get results with arbitrary precision
    numerator = BigInt(approximation)
    denominator = BigInt(1)
    for _ in 1:8 # Perform 10 iterations for better accuracy
        new_numerator = numerator^2 + S * denominator^2
        new_denominator = 2 * numerator * denominator
        numerator, denominator = new_numerator, new_denominator
    end

    return numerator, denominator
end

function arbitrary_precision_division(numerator, denominator, precision)
    # Integral division part
    integral_numbers = []
    current_remainder = numerator
    decimal_point_reached = false
    while true
        current_remainder_digits = length(string(current_remainder))
        decimal_taker = BigInt(10)^(current_remainder_digits - 1)
        while true
            taker_candidate = div(current_remainder, decimal_taker)
            division_result = div(taker_candidate, denominator)
            if division_result == 0
                decimal_taker = div(decimal_taker, 10)
                if decimal_taker == 0
                    decimal_point_reached = true
                    break
                end
            else
                current_remainder = current_remainder - division_result * denominator * decimal_taker
                integral_numbers = push!(integral_numbers, division_result)
                break
            end
        end

        if decimal_point_reached == true
            break
        end
    end
    if integral_numbers == []
        integral_numbers = [0]
    end

    # Decimal division part
    decimal_numbers = []
    current_remainder *= 10
    while length(decimal_numbers) < precision
        division_result = div(current_remainder, denominator)
        if division_result == 0
            decimal_numbers = push!(decimal_numbers, 0)
            current_remainder = current_remainder * 10
        else
            current_remainder = current_remainder - division_result * denominator
            decimal_numbers = push!(decimal_numbers, division_result)
            current_remainder = current_remainder * 10
        end
    end

    return integral_numbers, decimal_numbers
end

cumulative_sum = 0
for S in 1:100
    if sqrt(S) == floor(sqrt(S))
        continue
    end
    numerator, denominator = heron_approximation(S)
    integral_numbers, decimal_numbers = arbitrary_precision_division(numerator, denominator, 100)
    decimal_numbers_to_consider = 100 - length(integral_numbers)
    full_sum = sum(integral_numbers) + sum(decimal_numbers[1:decimal_numbers_to_consider])
    println("Sum of the first 100 decimal digits of the square root of ", S, ": ", full_sum)
    global cumulative_sum += full_sum
end

println("Total sum of the first 100 decimal digits of the square roots of the first 100 natural numbers: ", cumulative_sum)