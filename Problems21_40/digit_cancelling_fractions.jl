# Find denominator of product of digit cancelling fractions, less than one in value and containing two digits in numerator and denominator

function all_factors(n)
    factors = []
    for i in 1:floor(Int, sqrt(n))
        if n % i == 0
            push!(factors, i)
            push!(factors, Int(n / i))
        end
    end
    return factors
end

numerators = []
denominators = []

for i=10:99
    for j=10:99
        if i < j
            string_numerator = string(i)
            string_denominator = string(j)
            for k=1:2
                if occursin(string_denominator[k], string_numerator) && string_denominator[k] != '0'
                    # Check if fraction is equal after cancelling digit
                    cancelled_nominator = parse(Int, replace(string_numerator, string_denominator[k] => "", count=1))
                    cancelled_denominator = parse(Int, replace(string_denominator, string_denominator[k] => "", count=1))
                    original_fraction = i / j
                    cancelled_fraction = cancelled_nominator / cancelled_denominator
                    if abs(original_fraction - cancelled_fraction) < 0.00001
                        push!(numerators, i)
                        push!(denominators, j)
                    end
                end
            end
        end
    end
end

println("Numerators: ", numerators)
println("Denominators: ", denominators)

final_fraction_numerator = prod(numerators)
final_fraction_denominator = prod(denominators)

while true
    numerator_factors = all_factors(final_fraction_numerator)
    denominator_factors = all_factors(final_fraction_denominator)
    common_factors = intersect(numerator_factors, denominator_factors)
    if length(common_factors) == 1
        break
    end
    global final_fraction_denominator /= common_factors[end]
    global final_fraction_numerator /= common_factors[end]
end

println("The denominator of the product of digit cancelling fractions is: ", Int(final_fraction_denominator))