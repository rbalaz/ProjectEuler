# Find the minimal path sum from the top left to the bottom right by moving left, right, up, and down in 80 by 80 matrix.

include("../Utilities/miscellaneous_utilities.jl")
using .MiscellaneousUtilities

function dijkstra_min_path_sum(lines)
    line_boundary = length(lines)
    column_boundary = length(lines[1])
    vertex_count = line_boundary * column_boundary
    distances = fill(typemax(Int), vertex_count)
    distances[1] = lines[1][1]
    priority_queue = Dict{Int, Int}()
    visited = falses(vertex_count)
    # add starting vertex
    priority_queue[1] = distances[1]
    while true
        minimum_distance_vertex = get_key_with_minimum_value(priority_queue)
        minimum_distance = priority_queue[minimum_distance_vertex]
        visited[minimum_distance_vertex] = true
        delete!(priority_queue, minimum_distance_vertex)
        current_line = div(minimum_distance_vertex - 1, column_boundary) + 1
        current_column = mod(minimum_distance_vertex - 1, column_boundary) + 1

        if current_line == line_boundary && current_column == column_boundary
            return minimum_distance
        end

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
        if current_column > 1
            left_vertex = lines[current_line][current_column - 1]
            # Avoid revisiting the same vertex
            if visited[(current_line - 1) * column_boundary + current_column - 1] == false
                distances_index = (current_line - 1) * column_boundary + current_column - 1
                new_distance = minimum_distance + left_vertex
                if new_distance < distances[distances_index]
                    distances[distances_index] = new_distance
                    priority_queue[distances_index] = new_distance
                end
            end
        end
        if current_column < column_boundary
            right_vertex = lines[current_line][current_column + 1]
            # Avoid revisiting the same vertex
            if visited[(current_line - 1) * column_boundary + current_column + 1] == false
                distances_index = (current_line - 1) * column_boundary + current_column + 1
                new_distance = minimum_distance + right_vertex
                if new_distance < distances[distances_index]
                    distances[distances_index] = new_distance
                    priority_queue[distances_index] = new_distance
                end
            end
        end
    end
end

lines = readlines(joinpath(@__DIR__, "0081_matrix.txt"))
large_matrix = [parse.(Int, split(line, ",")) for line in lines]

minimum_path_sum = dijkstra_min_path_sum(large_matrix)

println("Dijkstra's algorithm solution for large matrix: ", minimum_path_sum)