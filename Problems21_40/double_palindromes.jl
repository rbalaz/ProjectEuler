# Find sum of all numbers, less than one million, which are palindromic in base 10 and in base 2.

function is_palindromic(n)
    reverse_number = reverse(n)
    if reverse_number[1] == '0'
        return false
    end
    return n == reverse_number
end

sum = 0
for i=1:1000000
    if is_palindromic(string(i)) && is_palindromic(string(i, base=2))
        println("Number: ", i, " is palindromic in both bases.")
        global sum += i
    end
end

println("Sum of all numbers, less than one million, which are palindromic in base 10 and in base 2: ", sum)