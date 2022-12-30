--[[
Name: day4.lua
Author: Patrick Ly
Description: Finding cleaning assignment overlaps.
]] --

stringx = require "pl.stringx"

function file_exists(fileName)
    local file = io.open(fileName, "r")
    if file then file:close() end

    return file ~= nil
end

function calculate_overlaps(fileName)
    local sum = 0

    local index = 0
    for line in io.lines(fileName) do
        local splitLine = stringx.split(line, ",")

        local clean1 = stringx.split(splitLine[1], "-")
        local clean2 = stringx.split(splitLine[2], "-")
        
        if tonumber(clean1[1]) <= tonumber(clean2[1]) and tonumber(clean1[2]) >= tonumber(clean2[2]) then
            sum = sum + 1
        elseif tonumber(clean2[1]) <= tonumber(clean1[1]) and tonumber(clean2[2]) >= tonumber(clean1[2]) then
            sum = sum + 1
        end

        index = index + 1
    end

    return sum
end

function calculate_overlaps_part2(fileName)
    local sum = 0

    local index = 0
    for line in io.lines(fileName) do
        local splitLine = stringx.split(line, ",")

        local clean1 = stringx.split(splitLine[1], "-")
        local clean1First = tonumber(clean1[1])
        local clean1Sec = tonumber(clean1[2])

        local clean2 = stringx.split(splitLine[2], "-")
        local clean2First = tonumber(clean2[1])
        local clean2Sec = tonumber(clean2[2])
        
        if clean1First <= clean2First and clean1Sec >= clean2Sec then
            -- print(clean1[1], "<=", clean2[1])
            -- print(clean1[2], ">=", clean2[2])
            -- print(clean1, clean2)
            sum = sum + 1
        elseif clean2First <= clean1First and clean2Sec >= clean1Sec then
            -- print(clean2[1], "<=", clean1[1])
            -- print(clean2[2], ">=", clean1[2])
            -- print(clean1, clean2)
            sum = sum + 1
        elseif clean1First >= clean2First and clean1First <= clean2Sec then
            sum = sum + 1
        elseif clean1Sec >= clean2First and clean1Sec <= clean2Sec then
            sum = sum + 1
        end

        index = index + 1
    end

    return sum
end

function main()
    local fileName = "input.txt"
    if not file_exists then print("The file doesn't exist:", fileName) return end

    print("The number of fully contained overlaps is:", calculate_overlaps(fileName))
    print("The number of overlaps is:", calculate_overlaps_part2(fileName))
end

main()
