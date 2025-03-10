# Find sum of even fibonacci numbers below 4 million

function fibonacci(upperBoundary)
    fib = [1, 2]
    while fib[end] < upperBoundary
        push!(fib, fib[end] + fib[end-1])
    end
    return fib
end

fib = fibonacci(4000000)
even_fib = filter(x -> x % 2 == 0, fib)
sum_of_even_fib = sum(even_fib)
println(sum_of_even_fib)