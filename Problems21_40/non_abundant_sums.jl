# Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.

function get_factors(n)
    factors = []
    for i in 1:floor(Int, sqrt(n))
        if n % i == 0
            push!(factors, i)
            if i != n / i
                push!(factors, n / i)
            end
        end
    end
    return factors
end

function get_abundant_numbers(limit)
    abundant_numbers = []
    for i=1:limit
        factors = get_factors(i)
        sum_factors = sum(factors) - i
        if sum_factors > i
            push!(abundant_numbers, i)
        end
    end

    return abundant_numbers
end

function get_abundant_sums(numbers)
    abundant_numbers_sums = []
    for i=1:lastindex(numbers)
        for j=i:lastindex(numbers)
            push!(abundant_numbers_sums, numbers[i] + numbers[j])
        end
    end
    return sort(unique(abundant_numbers_sums))
end

limit = 28123
relevant_numbers = []
abundant_numbers = get_abundant_numbers(limit)
abundant_numbers_sums = get_abundant_sums(abundant_numbers)
for i = 1:limit
    if !(i in abundant_numbers_sums)
        push!(relevant_numbers, i)
    end
end

println("Sum of all the positive integers which cannot be written as the sum of two abundant numbers: ", sum(relevant_numbers))
