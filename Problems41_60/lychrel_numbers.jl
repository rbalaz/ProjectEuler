# How many Lychrel numbers are there below ten-thousand?
# # A Lychrel number is a natural number that cannot form a palindrome through the iterative process of repeatedly reversing its digits and adding the resulting numbers.

function is_palindrome(n)
    s = string(n)
    return s == reverse(s)
end

function is_lychrel(n, max_iterations=50)
    current_value = BigInt(n)
    for _=1:max_iterations
        reversed_value = parse(BigInt, reverse(string(current_value)))
        current_value += reversed_value
        if is_palindrome(current_value)
            return false
        end
    end

    return true
end

lychrel_numbers = []

for i=1:9999
    if is_lychrel(i)
        push!(lychrel_numbers, i)
    end
end

println("Number of Lychrel numbers below 10,000: ", length(lychrel_numbers))