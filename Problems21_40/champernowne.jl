# Evaluate the product of 1st, 10th 100th, 1000th, 10000th, 100000th and 1000000th digits of the fractional part of the Champernowne constant.

champernowne = ""
current_number = 1
while (true)
    if length(champernowne) >= 1000000
        break
    end
    global champernowne *= string(current_number)
    global current_number += 1
end

final_value = parse(Int, champernowne[1])
for i in [10, 100, 1000, 10000, 100000]
    global final_value *= parse(Int, champernowne[i])
end

println("The product of the 1st, 10th, 100th, 1000th, 10000th, and 100000th digits of the fractional part of the Champernowne constant is: ", final_value)