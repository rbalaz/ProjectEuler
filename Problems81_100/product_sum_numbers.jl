# What is the sum of all the minimal product-sum numbers for 2 ≤ k ≤ 12000?

include("../Utilities/miscellaneous_utilities.jl")
using .MiscellaneousUtilities

function get_min_product_sum_numbers_by_factorizations(max_k; limit=2*max_k)
    minimal = fill(typemax(Int), max_k+1)

    function search(start_factor::Int, product::Int, sumv::Int, count::Int)
        println("search: start_factor=", start_factor, ", product=", product, ", sumv=", sumv, ", count=", count)
        maxf = div(limit, product)
        for f in start_factor:maxf
            newP = product * f
            if newP > limit
                break
            end
            newS = sumv + f
            newCount = count + 1
            k = newP - newS + newCount
            if k <= max_k
                if newP < minimal[k]
                    minimal[k] = newP
                end
            end
            search(f, newP, newS, newCount)
        end
    end

    search(2, 1, 0, 0)
    return minimal
end

function get_minimum_product_sum_numbers(maximum_k)
    # k is the number of terms in the product sum
    # the goal is the minimize the product sum number for each k 
    limit = 2*maximum_k
    minimum_product_sum_numbers = fill(typemax(Int), maximum_k+1)
    recursive_factor_deconstruction(2, 1, 0, 0, maximum_k, limit, minimum_product_sum_numbers)
    return minimum_product_sum_numbers
end

function recursive_factor_deconstruction(start_factor, current_product, current_sum, current_count, maximum_k, limit, minimum_product_sum_numbers)
    maximum_factor = div(limit, current_product)
    for factor in start_factor:maximum_factor
        new_product = current_product * factor
        if new_product > limit 
            break
        end
        new_sum = current_sum + factor
        new_count = current_count + 1
        # Calculation to take into account the number of 1's that would be needed to make the product sum equal to the product
        current_k = new_product - new_sum + new_count
        if current_k <= maximum_k
            if new_product < minimum_product_sum_numbers[current_k]
                minimum_product_sum_numbers[current_k] = new_product
            end
        end

        recursive_factor_deconstruction(factor, new_product, new_sum, new_count, maximum_k, limit, minimum_product_sum_numbers)
    end
end

max_k = 12000
minimum_product_sum_numbers = get_minimum_product_sum_numbers(max_k)
minimum_product_sum_numbers_unique = Set{Int}()
for k in 2:max_k
    v = minimum_product_sum_numbers[k]
    push!(minimum_product_sum_numbers_unique, v)
end
println("Sum of unique minimal product-sum numbers (k=2..", max_k, "): ", sum(minimum_product_sum_numbers_unique))