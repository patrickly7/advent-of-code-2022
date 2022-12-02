--[[
Name: day2.lua
Author: Patrick Ly
Description: Seeing if you can trust an elf's advice for how to play
rock paper scissors.
]] --

-- Points for your action
X_ROCK = 1
Y_PAPER = 2
Z_SCISSORS = 3

-- Points for the results
LOSS = 0
DRAW = 3
WIN = 6

function file_exists(fileName)
    local file = io.open(fileName, "r")
    if file then file:close() end

    return file ~= nil
end

function process_game_actions(fileName)
    local enemyActions = {}
    local playerActions = {}

    local index = 0
    for line in io.lines(fileName) do
        local playerTurn = false
        for action in string.gmatch(line, "%S") do
            if playerTurn
            then playerActions[index] = action
                playerTurn = false

            else
                enemyActions[index] = action
                playerTurn = true
            end
        end

        index = index + 1
    end

    return enemyActions, playerActions
end

function rock_paper_scissors_calculator_part1(enemyActions, playerActions)
    local totalScore = 0

    for i, enemyAction in pairs(enemyActions) do
        if enemyAction == "A" then -- ROCK
            if playerActions[i] == "X" then totalScore = totalScore + X_ROCK + DRAW
            elseif playerActions[i] == "Y" then totalScore = totalScore + Y_PAPER + WIN
            elseif playerActions[i] == "Z" then totalScore = totalScore + Z_SCISSORS + LOSS
            end
        elseif enemyAction == "B" then -- PAPER
            if playerActions[i] == "X" then totalScore = totalScore + X_ROCK + LOSS
            elseif playerActions[i] == "Y" then totalScore = totalScore + Y_PAPER + DRAW
            elseif playerActions[i] == "Z" then totalScore = totalScore + Z_SCISSORS + WIN
            end
        elseif enemyAction == "C" then -- SCISSORS
            if playerActions[i] == "X" then totalScore = totalScore + X_ROCK + WIN
            elseif playerActions[i] == "Y" then totalScore = totalScore + Y_PAPER + LOSS
            elseif playerActions[i] == "Z" then totalScore = totalScore + Z_SCISSORS + DRAW
            end
        end
    end

    return totalScore
end

function rock_paper_scissors_calculator_part2(enemyActions, playerActions)
    local totalScore = 0

    for i, enemyAction in pairs(enemyActions) do
        if enemyAction == "A" then -- ROCK
            if playerActions[i] == "X" then totalScore = totalScore + Z_SCISSORS + LOSS
            elseif playerActions[i] == "Y" then totalScore = totalScore + X_ROCK + DRAW
            elseif playerActions[i] == "Z" then totalScore = totalScore + Y_PAPER + WIN
            end
        elseif enemyAction == "B" then -- PAPER
            if playerActions[i] == "X" then totalScore = totalScore + X_ROCK + LOSS
            elseif playerActions[i] == "Y" then totalScore = totalScore + Y_PAPER + DRAW
            elseif playerActions[i] == "Z" then totalScore = totalScore + Z_SCISSORS + WIN
            end
        elseif enemyAction == "C" then -- SCISSORS
            if playerActions[i] == "X" then totalScore = totalScore + Y_PAPER + LOSS
            elseif playerActions[i] == "Y" then totalScore = totalScore + Z_SCISSORS + DRAW
            elseif playerActions[i] == "Z" then totalScore = totalScore + X_ROCK + WIN
            end
        end
    end

    return totalScore
end

function main()
    local fileName = "input.txt"
    if not file_exists then print("The file doesn't exist:", fileName) return end

    local enemyActions, playerActions = process_game_actions(fileName)

    print("The total score for Part 1 (XYZ are your actions) is:",
        rock_paper_scissors_calculator_part1(enemyActions, playerActions))
    print("The total score for Part 2 (XYZ is your goal) is:",
        rock_paper_scissors_calculator_part2(enemyActions, playerActions))
end

main()
