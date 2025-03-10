# Largest palindrome from a product of two three digit numbers.

function is_palindrome(value)
    return value == reverse(value)
end

function largest_palindrome()
    largest_palindrome = -1
    for i in 100:999
        for j in 100:999
            product = i * j
            if is_palindrome(string(product)) == true && product > largest_palindrome
                largest_palindrome = product
            end
        end
    end
    return largest_palindrome
end

println(largest_palindrome())