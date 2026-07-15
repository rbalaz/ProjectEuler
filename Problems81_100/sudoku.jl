# What is the sum of the 3-digit numbers found in the top left corner of each solved Sudoku grid?

struct SudokuGrid
    grid::Matrix{Int}
end

mutable struct FieldCandidates
    values::Vector{Int}
end

struct GridCandidates
    candidates::Matrix{FieldCandidates}
end

struct GuessStateSnapshot
    sudoku::SudokuGrid
    candidates::GridCandidates
    guess::Tuple{Int, Int, Int}  # (row, column, guessed_value)
end

function parse_sudoku_grids()
    lines = readlines(joinpath(@__DIR__, "0096_sudoku.txt"))
    grids = SudokuGrid[]
    lines_count = length(lines)
    for i in 2:10:lines_count
        grid_lines = lines[i:i+8]
        grid_matrix = [parse(Int, c) for line in grid_lines for c in line]
        push!(grids, SudokuGrid(permutedims(reshape(grid_matrix, 9, 9))))
    end

    return grids
end

function is_grid_valid(sudoku::SudokuGrid)
    # Check rows
    for i in 1:9
        row = sudoku.grid[i, :]
        value_count_helper = zeros(Int, 9)
        for value in row
            if value != 0
                value_count_helper[value] += 1
                if value_count_helper[value] > 1
                    return false
                end
            end
        end
    end
    # Check columns
    for j = 1:9
        column = sudoku.grid[:, j]
        values_count_helper = zeros(Int, 9)
        for value in column
            if value != 0
                values_count_helper[value] += 1
                if values_count_helper[value] > 1
                    return false
                end
            end
        end
    end
    # Check sub-grids
    for i in 0:2
        for j in 0:2
            sub_grid = sudoku.grid[i*3+1:i*3+3, j*3+1:j*3+3]
            value_count_helper = zeros(Int, 9)
            for value in sub_grid
                if value != 0
                    value_count_helper[value] += 1
                    if value_count_helper[value] > 1
                        return false
                    end
                end
            end
        end
    end
    return true
end

function is_grid_solved(sudoku::SudokuGrid)
    for i in 1:9
        for j in 1:9
            if sudoku.grid[i, j] == 0
                return false
            end
        end
    end
    return true
end

function initialize_candidates(sudoku::SudokuGrid)
    local_grid = GridCandidates([FieldCandidates(Int[]) for _ in 1:9, _ in 1:9])
    # Apply row rules
    for i in 1:9
        row = sudoku.grid[i, :]
        # For each empty cell, calculate candidates based on row
        for j in 1:9
            if sudoku.grid[i, j] == 0
                # Calculate candidates for this cell
                field_candidates = FieldCandidates(setdiff(1:9, row))
                # Store candidates for this cell
                local_grid.candidates[i, j] = field_candidates
            end
        end
    end
    # Apply column rules
    for j in 1:9
        column = sudoku.grid[:, j]
        for i in 1:9
            if sudoku.grid[i, j] == 0
                field_candidates = local_grid.candidates[i, j]
                # Update candidates based on column
                field_candidates.values = setdiff(field_candidates.values, column)
            end
        end
    end
    # Apply sub-grid rules
    for i in 0:2
        for j in 0:2
            sub_grid = sudoku.grid[i*3+1:i*3+3, j*3+1:j*3+3]
            for x in 1:3
                for y in 1:3
                    if sudoku.grid[i*3+x, j*3+y] == 0
                        field_candidates = local_grid.candidates[i*3+x, j*3+y]
                        # Update candidates based on sub-grid
                        field_candidates.values = setdiff(field_candidates.values, sub_grid)
                    end
                end
            end
        end
    end

    return local_grid
end

function update_candidates(grid::GridCandidates, sudoku::SudokuGrid)
    # Apply row rules
    for i in 1:9
        row = sudoku.grid[i, :]
        # For each empty cell, calculate candidates based on row
        for j in 1:9
            if sudoku.grid[i, j] == 0
                # Calculate candidates for this cell
                field_candidates = FieldCandidates(setdiff(grid.candidates[i, j].values, row))
                # Store candidates for this cell
                grid.candidates[i, j] = field_candidates
            end
        end
    end
    # Apply column rules
    for j in 1:9
        column = sudoku.grid[:, j]
        for i in 1:9
            if sudoku.grid[i, j] == 0
                field_candidates = grid.candidates[i, j]
                # Update candidates based on column
                field_candidates.values = setdiff(field_candidates.values, column)
            end
        end
    end
    # Apply sub-grid rules
    for i in 0:2
        for j in 0:2
            sub_grid = sudoku.grid[i*3+1:i*3+3, j*3+1:j*3+3]
            for x in 1:3
                for y in 1:3
                    if sudoku.grid[i*3+x, j*3+y] == 0
                        field_candidates = grid.candidates[i*3+x, j*3+y]
                        # Update candidates based on sub-grid
                        field_candidates.values = setdiff(field_candidates.values, sub_grid)
                    end
                end
            end
        end
    end
end

function iterate_over_candidates(grid::GridCandidates, sudoku::SudokuGrid)
    changed = false
    # Do initial check too see if any cells can be filled
    for i in 1:9
        for j in 1:9
            if sudoku.grid[i, j] == 0 && length(grid.candidates[i, j].values) == 1
                field_candidates = grid.candidates[i, j]
                sudoku.grid[i, j] = field_candidates.values[1]
                # Clear candidates for this cell since it is now filled
                grid.candidates[i, j].values = []
                changed = true
            end
        end
    end

    return changed
end

# Unique single solving technique
function apply_unique_single_solver(grid::GridCandidates)
    # Unique single is candidate that only appears once in a row, column or sub-grid, regardless of how many candidates are in the cell
    # Look for row unique singles
    for i in 1:9
        # Initialize a vector of 9 zeros
        candidate_count_helper = zeros(Int, 9)
        for j in 1:9
            row_candidates = grid.candidates[i, j].values
            for candidate in row_candidates
                candidate_count_helper[candidate] += 1
            end
        end
        # Check if any candidate appears only once in the row
        for candidate in 1:9
            if candidate_count_helper[candidate] == 1
                # Find the cell that has this candidate and fill it
                for j in 1:9
                    if candidate in grid.candidates[i, j].values
                        grid.candidates[i, j].values = [candidate]
                        return true
                    end
                end
            end
        end
    end
    # Look for column unique singles
    for j in 1:9
        candidate_count_helper = zeros(Int, 9)
        for i in 1:9
            column_candidates = grid.candidates[i, j].values
            for candidate in column_candidates
                candidate_count_helper[candidate] += 1
            end
        end
        # Check if any candidate appears only once in the column
        for candidate in 1:9
            if candidate_count_helper[candidate] == 1
                # Find the cell that has this candidate and fill it
                for i in 1:9
                    if candidate in grid.candidates[i, j].values
                        grid.candidates[i, j].values = [candidate]
                        return true
                    end
                end
            end
        end
    end
    # Look for sub-grid unique singles
    for i in 0:2
        for j in 0:2
            candidate_count_helper = zeros(Int, 9)
            for x in 1:3
                for y in 1:3
                    sub_grid_candidates = grid.candidates[i*3+x, j*3+y].values
                    for candidate in sub_grid_candidates
                        candidate_count_helper[candidate] += 1
                    end
                end
            end
            # Check if any candidate appears only once in the sub-grid
            for candidate in 1:9
                if candidate_count_helper[candidate] == 1
                    # Find the cell that has this candidate and fill it
                    for x in 1:3
                        for y in 1:3
                            if candidate in grid.candidates[i*3+x, j*3+y].values
                                grid.candidates[i*3+x, j*3+y].values = [candidate]
                                return true
                            end
                        end
                    end
                end
            end
        end
    end

    return false
end

function apply_guess(grid::GridCandidates, sudoku::SudokuGrid, snapshots::Vector{GuessStateSnapshot})
    # Pick a cell with the least number of candidates and make a guess
    minimum_candidates = 10
    stored_i = 0
    stored_j = 0
    for i in 1:9
        for j in 1:9
            if length(grid.candidates[i, j].values) > 1 && length(grid.candidates[i, j].values) < minimum_candidates
                minimum_candidates = length(grid.candidates[i, j].values)
                stored_i = i
                stored_j = j
            end
        end
    end
    
    # Make a guess with the first candidate
    guess_value = grid.candidates[stored_i, stored_j].values[1]
    # Add the current state to snapshots before making the guess
    push!(snapshots, GuessStateSnapshot(deepcopy(sudoku), deepcopy(grid), (stored_i, stored_j, guess_value)))
    sudoku.grid[stored_i, stored_j] = guess_value
    grid.candidates[stored_i, stored_j].values = []
end

function rollback_guess(snapshots::Vector{GuessStateSnapshot})
    # This should never be hit, only for debugging
    if isempty(snapshots)
        throw(ErrorException("No more snapshots to rollback to"))
    end
    
    # Pop the last snapshot and restore the state
    last_snapshot = pop!(snapshots)
    sudoku = last_snapshot.sudoku
    grid = last_snapshot.candidates
    guess = last_snapshot.guess

    # Remove the guessed value from the candidates of the guessed cell
    i, j, guessed_value = guess
    filter!(x -> x != guessed_value, grid.candidates[i, j].values)

    return sudoku, grid
end

function solve_grid(grid::SudokuGrid)
    candidates = initialize_candidates(grid)
    changed = true
    while changed
        changed = false
        if is_grid_solved(grid)
            return grid
        end
        changed |= iterate_over_candidates(candidates, grid)
        if changed == false
            changed |= apply_unique_single_solver(candidates)
            update_candidates(candidates, grid)
        end
        if changed == false
            # No more progress can be made with current techniques, enter guess subroutine
            return guess_subroutine(grid, candidates)
        else
            update_candidates(candidates, grid)
        end
    end
end

function guess_subroutine(grid::SudokuGrid, candidates::GridCandidates)
    current_grid = grid
    current_candidates = candidates
    snapshots = GuessStateSnapshot[]
    changed = true
    while true
        changed = false
        if is_grid_solved(current_grid)
            return current_grid
        end
        if is_grid_valid(current_grid) == false
            # Rollback to last snapshot and try a different guess
            current_grid, current_candidates = rollback_guess(snapshots)
            # Verify that the grid is valid after rollback, if not, rollback again
            is_valid = is_grid_valid(current_grid)
            while is_valid == false
                current_grid, current_candidates = rollback_guess(snapshots)
                is_valid = is_grid_valid(current_grid)
            end
            continue
        end
        changed |= iterate_over_candidates(current_candidates, current_grid)
        if changed == false
            changed |= apply_unique_single_solver(current_candidates)
        end
        if changed == false
            # No more progress can be made with current techniques, make a again guess
            apply_guess(current_candidates, current_grid, snapshots)
        end

        update_candidates(current_candidates, current_grid)
    end
end

function pretty_print_grid(grid::SudokuGrid)
    # Print the grid in a readable format using ascii art, including separators for 3x3 sub-grids
    for i in 1:9
        if i == 4 || i == 7
            println("-"^21)
        end
        for j in 1:9
            if j == 4 || j == 7
                print("| ")
            end
            print(grid.grid[i, j], " ")
        end
        println()
    end
end

grids = parse_sudoku_grids()

top_left_corner_sum = 0
iterator = 1
for grid in grids
    global iterator += 1
    solved_sudoku = solve_grid(grid)
    global top_left_corner_sum += solved_sudoku.grid[1, 1] * 100 + solved_sudoku.grid[1, 2] * 10 + solved_sudoku.grid[1, 3]
end

println("Sum of the 3-digit numbers found in the top left corner of each solved Sudoku grid: ", top_left_corner_sum)