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

triangle_small = """
3
7 4
2 4 6
8 5 9 3
"""

triangle_small_rows = parse_triangle(triangle_small)
println("[Breadth first search] Maximum path sum of small triangle is: " * string(breadth_first_search(triangle_small_rows)))

triangle_large = """
75
95 64
17 47 82
18 35 87 10
20 04 82 47 65
19 01 23 75 03 34
88 02 77 73 07 63 67
99 65 04 28 06 16 70 92
41 41 26 56 83 40 80 70 33
41 48 72 33 47 32 37 16 94 29
53 71 44 65 25 43 91 52 97 51 14
70 11 33 28 77 73 17 78 39 68 17 57
91 71 52 38 17 14 91 43 58 50 27 29 48
63 66 04 68 89 53 67 30 73 16 69 87 40 31
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
"""

triangle_large_rows = parse_triangle(triangle_large)
println("[Breadth first search] Maximum path sum of small triangle is: " * string(breadth_first_search(triangle_large_rows)))