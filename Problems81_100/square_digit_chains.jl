# How many square digit chains, with a starting number below ten million, will arrive at 89?

function iterate_square_digit_chain(n)
    current_number = n
    while true
        number_digits = digits(current_number)
        current_number = sum(digit^2 for digit in number_digits)
        if current_number == 1 || current_number == 89
            return current_number
        end
    end
end

expected_digit_chains_count = 0
upper_limit = 9_999_999
for i in 1:upper_limit
    if iterate_square_digit_chain(i) == 89
        global expected_digit_chains_count += 1
    end
end

println("Number of square digit chains ending in 89: $expected_digit_chains_count")