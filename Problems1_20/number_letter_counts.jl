function count_letters_in_number(number)
    number_string = string(number)
    number_length = length(number_string)
    if number_length == 1
        return get_letter_count_of_single_digit(number)
    end
    if number_length == 2
        return get_letter_count_of_two_digits(number)
    end
    if number_length == 3
        return get_letter_count_of_three_digits(number_string)
    end
    if number == 1000
        return 11 # one thousand
    end
end

function get_letter_count_of_single_digit(digit)
    if digit == 1 # one
        return 3
    elseif digit == 2 # two
        return 3
    elseif digit == 3 # three
        return 5
    elseif digit == 4 # four
        return 4
    elseif digit == 5 # five
        return 4
    elseif digit == 6 # six
        return 3
    elseif digit == 7 # seven
        return 5
    elseif digit == 8 # eight
        return 5
    elseif digit == 9 # nine
        return 4
    else # zero
        return 0
    end
end

function get_letter_count_of_single_digit_short(digit)
    if digit == 3 # thir
        return 4
    elseif digit == 4 # four
        return 4
    elseif digit == 5 # fif
        return 3
    elseif digit == 6 # six
        return 3
    elseif digit == 7 # seven
        return 5
    elseif digit == 8 # eigh
        return 4
    elseif digit == 9 # nine
        return 4
    end
end

function get_letter_count_of_two_digits(digits)
    if digits == 10 # ten
        return 3
    elseif digits == 11 # eleven
        return 6
    elseif digits == 12 # twelve
        return 6
    end

    secondDigit = parse(Int, string(digits)[2])

    if digits < 20
        return get_letter_count_of_single_digit_short(secondDigit) + 4 # 4 is for "teen"
    end
    if digits < 30
        return get_letter_count_of_single_digit(secondDigit) + 6 # 6 is for "twenty"
    end
    if digits < 40
        return get_letter_count_of_single_digit(secondDigit) + 6 # 6 is for "thirty"
    end
    if digits < 50
        return get_letter_count_of_single_digit(secondDigit) + 5 # 5 is for "forty"
    end
    if digits < 60
        return get_letter_count_of_single_digit(secondDigit) + 5 # 5 is for "fifty"
    end
    if digits < 70
        return get_letter_count_of_single_digit(secondDigit) + 5 # 5 is for "sixty"
    end
    if digits < 80
        return get_letter_count_of_single_digit(secondDigit) + 7 # 7 is for "seventy"
    end
    if digits < 90
        return get_letter_count_of_single_digit(secondDigit) + 6 # 6 is for "eighty"
    end
    if digits < 100
        return get_letter_count_of_single_digit(secondDigit) + 6 # 6 is for "ninety"
    end
end

function get_letter_count_of_three_digits(digits_string)
    first_digit_count = get_letter_count_of_single_digit(parse(Int, digits_string[1]))
    connection_count = 7 # "hundred"
    last_two_digits = parse(Int, digits_string[2:3])
    if last_two_digits == 0
        return first_digit_count + connection_count
    end
    connection_count += 3 # "and"
    if last_two_digits < 10
        remainder_count = get_letter_count_of_single_digit(parse(Int, digits_string[3]))
    else
        remainder_count = get_letter_count_of_two_digits(last_two_digits)
    end    
    return first_digit_count + connection_count + remainder_count
end

sum = 0
for i = 1:1000
    global sum += count_letters_in_number(i)
end

println("Total number of letters between numbers 1 and 1000 is: " * string(sum))