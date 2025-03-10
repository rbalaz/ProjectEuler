# Find the starting number, under one million, that produces the longest Collatz sequence.

function next_collatz_number(n)
    if n % 2 == 0
        return n / 2
    else
        return 3n + 1
    end
end

function generate_collatz_sequence(n)
    current_collatz_number = n
    collatz_sequence = []
    while current_collatz_number > 1
        current_collatz_number = next_collatz_number(current_collatz_number)
        push!(collatz_sequence, current_collatz_number)
    end
    return collatz_sequence
end

longest_collatz_sequence_length = 0
longest_sequence_starting_number = 0
for i = 1:1e6-1
    collatz_sequence = generate_collatz_sequence(i)
    if length(collatz_sequence) > longest_collatz_sequence_length
        global longest_collatz_sequence_length = length(collatz_sequence)
        global longest_sequence_starting_number = i
    end
end

println("Longest Collatz sequence starting number: ", longest_sequence_starting_number)