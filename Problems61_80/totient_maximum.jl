# Find the value of n, 1 < n < 10^6, for which n/φ(n) is a maximum.

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

limit = 1_000_000
phi = compute_totients(limit)

totient_maximum = 0.0
max_n = 0
for n in 2:limit
    current_ratio = n / phi[n]
    if current_ratio > totient_maximum
        global totient_maximum = current_ratio
        global max_n = n
    end
end

println("Final maximum ratio n/φ(n) = $totient_maximum at n = $max_n")