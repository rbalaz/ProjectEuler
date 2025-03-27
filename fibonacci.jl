# What is the index of the first term in the Fibonacci sequence to contain 1000 digits?

fib_n = BigInt(1)
fib_n1 = BigInt(1)
index = 2
while true
    global index += 1
    fib_new = fib_n + fib_n1
    if length(string(fib_new)) >= 1000
        break
    end
    global fib_n = fib_n1
    global fib_n1 = fib_new
end

println("Index of the first term in the Fibonacci sequence to contain 1000 digits: " * string(index))