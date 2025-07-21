# Find increasing arithmetic sequence of 4 digit prime numbers that are permutations of each other

function is_prime(n)
    if n < 2
        return false
    end
    for i in 2:floor(Int, sqrt(n))
        if n % i == 0
            return false
        end
    end
    return true
end

function is_permutation(a, b)
    return sort(collect(string(a))) == sort(collect(string(b)))
end

four_digit_primes = []
for i=1000:9999
    if is_prime(i)
        push!(four_digit_primes, i)
    end
end

sequences = []
for i in eachindex(four_digit_primes)
    if sequences.size[1] > 0 && any(seq -> seq[1] == four_digit_primes[i], sequences)
        continue
    end
    current_sequence = [four_digit_primes[i]]
    for j in (i+1):length(four_digit_primes)
        if is_permutation(four_digit_primes[i], four_digit_primes[j])
            push!(current_sequence, four_digit_primes[j])
        end
    end

    if length(current_sequence) >= 3
        push!(sequences, current_sequence)
    end

end

valid_sequences = []
for sequence in sequences
    for i=1:length(sequence)-2
        for j=i+1:length(sequence)-1
            for k=j+1:length(sequence)
                first_difference = sequence[j] - sequence[i]
                second_difference = sequence[k] - sequence[j]
                if first_difference == second_difference
                    if valid_sequences.size[1] > 0 && any(seq -> seq[1] == sequence[i], valid_sequences)
                        continue
                    end
                    push!(valid_sequences, [sequence[i], sequence[j], sequence[k]])
                    println("Found arithmetic sequence: ", [sequence[i], sequence[j], sequence[k]])
                end
            end
        end
    end
end

for sequence in valid_sequences
    println("Concatenated number from valid sequence: ", sequence[1], "", sequence[2], "", sequence[3])
end