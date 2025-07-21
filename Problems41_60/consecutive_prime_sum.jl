# Which prime, below one-million, can be written as the sum of the most consecutive primes?

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


primes = []
for i=1:1_000_000
    if is_prime(i)
        push!(primes, i)
    end
end

longest_sequence_length = 0
sequence_sum = 0
for i in eachindex(primes)
    sum = primes[i]
    for j = i+1:length(primes)
        sum += primes[j]
        if sum > 1_000_000
            break
        end
        if is_prime(sum)
            sequence_length = j - i + 1
            if sequence_length > longest_sequence_length
                global longest_sequence_length = sequence_length
                global sequence_sum = sum
            end
        end
    end
end

println("Longest sequence length: $longest_sequence_length")
println("Prime as a result of sum of the sequence: $sequence_sum")