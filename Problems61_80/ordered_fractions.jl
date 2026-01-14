# By listing the set of reduced proper fractions for d ≤ 1,000,000 in ascending order of size, 
# find the numerator of the fraction immediately to the left of 3/7.

limit = 1_000_000
target_fraction = "3/7"
target_value = 3/7
closest_fraction_value = 0
closest_fraction = ""
closest_approximations_not_found_streak = 0
for i = limit:-1:2
    numerator_limit = ceil(Int, (i / 2))
    for j = numerator_limit:-1:1
        if j/i < target_value
            current_closest_fraction_value = j/i
            if current_closest_fraction_value > closest_fraction_value
                global closest_approximations_not_found_streak = 0
                global closest_fraction_value = current_closest_fraction_value
                global closest_fraction = "$j/$i"
            else
                global closest_approximations_not_found_streak += 1
            end
            break
        end
    end

    if closest_approximations_not_found_streak > 1000
        break
    end
end

println("Closest fraction to the left of $target_fraction is $closest_fraction with value $closest_fraction_value")