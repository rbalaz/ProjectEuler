# Find the sum of digits in the numerator of the 100th convergent of the continued fraction for e(Euler's number).

function convergent_numerator_euler(n)

    fractions_euler = []
    for i=1:n
        if i == 1
            push!(fractions_euler, 2)
        else 
            if i % 3 == 0
                push!(fractions_euler, 2 * (i ÷ 3))
            else
                push!(fractions_euler, 1)
            end
        end

    end

    numerator = BigInt(0)
    denominator = BigInt(0)
    for i in reverse(fractions_euler)
        if denominator == 0
            denominator = BigInt(1)
            numerator = BigInt(i)
        else
            temp = denominator
            denominator = numerator
            numerator = temp + i * numerator
        end
    end

    return numerator
end

numerator_hundred = convergent_numerator_euler(100)
println("The numerator of the 100th convergent of e is: ", numerator_hundred)
sum_digits = sum(digit -> parse(Int, digit), string(numerator_hundred))
println("The sum of the digits in the numerator of the 100th convergent of e is: ", sum_digits)