--[[
Name: day5.lua
Author: Patrick Ly
Description: Organizing crates to create a message.
]] --

stringx = require "pl.stringx"

-- Part 1 Stacks
stacks = {
    {"D", "T", "R", "B", "J", "L", "W", "G"}, -- 1
    {"S", "W", "C"}, -- 2
    {"R", "Z", "T", "M"}, --3
    {'D', 'T', 'C', 'H', 'S', 'P', 'V'}, -- 4
    {'G', 'P', 'T', 'L', 'D', 'Z'}, -- 5
    {'F', 'B', 'R', 'Z', 'J', 'Q', 'C', 'D'}, -- 6
    {'S', 'B', 'D', 'J', 'M', 'F', 'T', 'R'}, -- 7
    {'L', 'H', 'R', 'B', 'T', 'V', 'M'}, -- 8
    {'Q', 'P', 'D', 'S', 'V'}, -- 9
}

stacksSize = {
    8, 3, 4, 7, 6, 8, 8, 7, 5
}

-- Part 2 Stacks
stacks2 = {
    {"D", "T", "R", "B", "J", "L", "W", "G"}, -- 1
    {"S", "W", "C"}, -- 2
    {"R", "Z", "T", "M"}, --3
    {'D', 'T', 'C', 'H', 'S', 'P', 'V'}, -- 4
    {'G', 'P', 'T', 'L', 'D', 'Z'}, -- 5
    {'F', 'B', 'R', 'Z', 'J', 'Q', 'C', 'D'}, -- 6
    {'S', 'B', 'D', 'J', 'M', 'F', 'T', 'R'}, -- 7
    {'L', 'H', 'R', 'B', 'T', 'V', 'M'}, -- 8
    {'Q', 'P', 'D', 'S', 'V'}, -- 9
}

stacksSize2 = {
    8, 3, 4, 7, 6, 8, 8, 7, 5
}

function file_exists(fileName)
    local file = io.open(fileName, "r")
    if file then file:close() end

    return file ~= nil
end

function print_array(arr) 
    local str = ''
    for k, v in pairs(arr) do
        str = str..v
    end
    print(str)
end

function move_crates(fileName)
    local message = ''

    for line in io.lines(fileName) do
        local splitLine = stringx.split(line, " ")

        local totalMoved = tonumber(splitLine[2])
        local source = tonumber(splitLine[4])
        local destination = tonumber(splitLine[6])

        for moves = totalMoved, 1, -1 do
            local movedCrate = table.remove(stacks[source])
            stacksSize[source] = stacksSize[source] - 1

            -- print('moving', movedCrate, 'from', source, 'to', destination)

            table.insert(stacks[destination], movedCrate)
            stacksSize[destination] = stacksSize[destination] + 1

            -- print_array(stacks[source])
            -- print_array(stacks[destination])
        end

        ::continue::
        -- print('---')
    end

    for i = 1, 9, 1 do
        message = message..stacks[i][stacksSize[i]]
    end

    return message
end

function move_crates_part2(fileName)
    local message = ''

    for line in io.lines(fileName) do
        local splitLine = stringx.split(line, " ")

        local totalMoved = tonumber(splitLine[2])
        local source = tonumber(splitLine[4])
        local destination = tonumber(splitLine[6])

        local movedCrates = {}
        for moves = totalMoved, 1, -1 do
            local movedCrate = table.remove(stacks2[source])
            stacksSize2[source] = stacksSize2[source] - 1

            table.insert(movedCrates, movedCrate)
        end

        -- print(movedCrates)
        for moves = totalMoved, 1, -1 do
            local movedCrate = table.remove(movedCrates)

            table.insert(stacks2[destination], movedCrate)
            stacksSize2[destination] = stacksSize2[destination] + 1
        end

        ::continue::
        -- print('---')
    end

    for i = 1, 9, 1 do
        message = message..stacks2[i][stacksSize2[i]]
    end

    return message
end

function main()
    local fileName = "modifiedInput.txt"
    if not file_exists then print("The file doesn't exist:", fileName) return end

    print("The final message is:", move_crates(fileName))
    print("The final message (part 2) is:", move_crates_part2(fileName))
end

main()
