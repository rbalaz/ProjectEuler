# Find the last ten digits of the sum of series n^n for n = 1 to 1000

function last_n_decimal_power(n, digits)
    current_result = 1
    for _=1:n
        current_result *= n
        current_result = truncate_to_n_digits(current_result, digits)
    end

    return current_result
end

function truncate_to_n_digits(n, digits)
    string_number = string(n)
    if length(string_number) <= digits
        return n
    else
        truncated_string = reverse(reverse(string_number)[1:digits])
        return parse(Int, truncated_string)
    end
end

current_result = 0
for i=1:1000
    global current_result += last_n_decimal_power(i, 10)
    global current_result = truncate_to_n_digits(current_result, 10)
end

println("The last ten digits of the sum of series n^n for n = 1 to 1000 is: ", current_result)