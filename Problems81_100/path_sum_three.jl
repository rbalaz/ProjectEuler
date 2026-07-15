# Find the minimal path sum from the left column to the right column in 80x80 matrix.

include("../Utilities/miscellaneous_utilities.jl")
using .MiscellaneousUtilities

function dijkstra_min_path_sum(lines, starting_row)
    line_boundary = length(lines)
    column_boundary = length(lines[1])
    vertex_count = line_boundary * column_boundary
    distances = fill(typemax(Int), vertex_count)
    starting_node_index = (starting_row - 1) * column_boundary + 1
    distances[starting_node_index] = lines[starting_row][1]
    priority_queue = Dict{Int, Int}()
    visited = falses(vertex_count)
    # add starting vertex
    priority_queue[starting_node_index] = distances[starting_node_index]
    while true
        if isempty(priority_queue)
            break
        end
        
        minimum_distance_vertex = get_key_with_minimum_value(priority_queue)
        minimum_distance = priority_queue[minimum_distance_vertex]
        visited[minimum_distance_vertex] = true
        delete!(priority_queue, minimum_distance_vertex)
        current_line = div(minimum_distance_vertex - 1, column_boundary) + 1
        current_column = mod(minimum_distance_vertex - 1, column_boundary) + 1
        if current_line > 1
            above_vertex = lines[current_line - 1][current_column]
            # Avoid revisiting the same vertex
            if visited[(current_line - 2) * column_boundary + current_column] == false
                distances_index = (current_line - 2) * column_boundary + current_column
                new_distance = minimum_distance + above_vertex
                if new_distance < distances[distances_index]
                    distances[distances_index] = new_distance
                    priority_queue[distances_index] = new_distance
                end
            end
        end
        if current_line < line_boundary
            below_vertex = lines[current_line + 1][current_column]
            # Avoid revisiting the same vertex
            if visited[(current_line) * column_boundary + current_column] == false
                distances_index = (current_line) * column_boundary + current_column
                new_distance = minimum_distance + below_vertex
                if new_distance < distances[distances_index]
                    distances[distances_index] = new_distance
                    priority_queue[distances_index] = new_distance
                end
            end
        end
        if current_column < column_boundary
            right_vertex = lines[current_line][current_column + 1]
            distances_index = (current_line - 1) * column_boundary + current_column + 1
            new_distance = minimum_distance + right_vertex
            if new_distance < distances[distances_index]
                distances[distances_index] = new_distance
                priority_queue[distances_index] = new_distance
            end
        end
    end

    minimum_distance = typemax(Int)
    for row in 1:line_boundary
        last_column_index = (row - 1) * column_boundary + column_boundary
        if distances[last_column_index] < minimum_distance
            minimum_distance = distances[last_column_index]
        end
    end

    return minimum_distance
end

minimum_path_sum = typemax(Int)

lines = readlines(joinpath(@__DIR__, "0081_matrix.txt"))
large_matrix = [parse.(Int, split(line, ",")) for line in lines]

for starting_row in 1:length(large_matrix)
    result = dijkstra_min_path_sum(large_matrix, starting_row)
    if result < minimum_path_sum
        global minimum_path_sum = result
    end
end

println("Dijkstra's algorithm solution for large matrix: ", minimum_path_sum)