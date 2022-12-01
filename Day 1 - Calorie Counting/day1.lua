--[[
Name: day1.lua
Author: Patrick Ly
Description: Finds out which elf has the most calories and determines what that calorie count is.
]] --

file_name = "input.txt"
dict = {}

function file_exists(file_name)
    local file = io.open(file_name, "r")
    if file then file:close() end
    return file ~= nil
end

function main()
    local num = 1
    local max_calories = 0
    local backup_calories = 0
    local second_backup_calories = 0

    if not file_exists
    then print("not here") return end

    for line in io.lines(file_name) do
        if line == ""
        then
            if max_calories < dict[num]
            then
                second_backup_calories = backup_calories
                backup_calories = max_calories
                max_calories = dict[num]
            else
                if backup_calories < dict[num]
                then
                    second_backup_calories = backup_calories
                    backup_calories = dict[num]
                else if second_backup_calories < dict[num] then second_backup_calories = dict[num] end
                end
            end
            num = num + 1
        else
            if dict[num] == nil
            then dict[num] = tonumber(line)
            else
                dict[num] = dict[num] + tonumber(line)
            end
        end
    end

    print("The elf with the most calories is carrying:", max_calories)
    print(max_calories)
    print(backup_calories)
    print(second_backup_calories)
    print("The top three elves carrying the most calories are carrying:",
        max_calories + backup_calories + second_backup_calories)
end

main()
