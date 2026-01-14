# Find the value of n, 1 < n < 10^7, for which φ(n) is a permutation of n and the ratio n/φ(n) produces a minimum.

function is_permutation(a, b)
    return sort(digits(a)) == sort(digits(b))
end

function compute_totients(limit)
    phi = collect(1:limit)
    phi[1] = 1
    for i in 2:limit
        if phi[i] == i  # i is prime
            for j in i:i:limit
                phi[j] -= phi[j] ÷ i
            end
        end
    end
    return phi
end

limit = 10_000_000
phi = compute_totients(limit)
totient_permutation_minimum = Inf
min_n = 0
for n in 2:limit
    if is_permutation(n, phi[n])
        current_ratio = n / phi[n]
        if current_ratio < totient_permutation_minimum
            global totient_permutation_minimum = current_ratio
            global min_n = n
        end
    end
end

println("Final minimum ratio n/φ(n) = $totient_permutation_minimum at n = $min_n")