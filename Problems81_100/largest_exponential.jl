# Determine which line number contains the largest exponential value

lines = readlines(joinpath(@__DIR__, "0099_base_exp.txt"))

largest_value = 0
largest_value_line = 0
for i in eachindex(lines)
    line = lines[i]
    base, exponent = split(line, ",")
    log_value = parse(Int, exponent) * log(parse(Int, base))
    if log_value > largest_value
        global largest_value = log_value
        global largest_value_line = i
    end
end

println("The line number with the largest exponential value is: $largest_value_line")