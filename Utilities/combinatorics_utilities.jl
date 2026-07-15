module CombinatoricsUtilities

export is_permutation, is_palindrome    

function is_permutation(a, b)
    return sort(digits(a)) == sort(digits(b))
end

function is_palindrome(n)
    s = string(n)
    return s == reverse(s)
end

end