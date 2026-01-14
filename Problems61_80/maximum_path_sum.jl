# Find the maximum total from top to bottom of the triangle by only moving to adjacent numbers on the row below

function parse_triangle(triangle)
    lines = split(triangle, "\n")
    rows = []
    for line in lines
        if line != ""
            push!(rows, [parse(Int, x) for x in split(line, " ")])
        end
    end

    return rows
end

function breadth_first_search(rows)
    current_sums = [rows[1][1]]
    for row in rows[2:end]
        next_sums = []
        for (i, value) in enumerate(row)
            if i == 1
                push!(next_sums, current_sums[1] + value)
            elseif i == length(row)
                push!(next_sums, current_sums[end] + value)
            else
                push!(next_sums, max(current_sums[i-1], current_sums[i]) + value)
            end
        end
        current_sums = next_sums
    end
    return maximum(current_sums)
end

triangle = read(joinpath(@__DIR__, "0067_triangle.txt"), String)
rows = parse_triangle(triangle)
max_sum = breadth_first_search(rows)
println("[Breadth first search] Maximum path sum of full triangle is: " * string(max_sum))