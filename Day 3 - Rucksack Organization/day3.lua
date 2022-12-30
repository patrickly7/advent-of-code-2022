--[[
Name: day3.lua
Author: Patrick Ly
Description: Prioritizing items in your rucksack.
]] --

-- Priorities
PRIORITIES = {
    a = 1,
    b = 2,
    c = 3,
    d = 4,
    e = 5,
    f = 6,
    g = 7,
    h = 8,
    i = 9,
    j = 10,
    k = 11,
    l = 12,
    m = 13,
    n = 14,
    o = 15,
    p = 16,
    q = 17,
    r = 18,
    s = 19,
    t = 20,
    u = 21,
    v = 22,
    w = 23,
    x = 24,
    y = 25,
    z = 26,
    A = 27,
    B = 28,
    C = 29,
    D = 30,
    E = 31,
    F = 32,
    G = 33,
    H = 34,
    I = 35,
    J = 36,
    K = 37,
    L = 38,
    M = 39,
    N = 40,
    O = 41,
    P = 42,
    Q = 43,
    R = 44,
    S = 45,
    T = 46,
    U = 47,
    V = 48,
    W = 49,
    X = 50,
    Y = 51,
    Z = 52
}

function file_exists(fileName)
    local file = io.open(fileName, "r")
    if file then file:close() end

    return file ~= nil
end

function calculate_priority_total(fileName)
    local sum = 0

    local index = 0
    for line in io.lines(fileName) do
        local length = string.len(line)
        local firstSack = string.sub(line, 1, length/2)
        local secondSack = string.sub(line, (length/2) + 1, length)
        for i = 1, #firstSack do
            local char = firstSack:sub(i, i)
            if string.find(secondSack, char)
            then
                -- print('Bag', index, ":", PRIORITIES[char])
                sum = sum + PRIORITIES[char]
                goto continue
            end
        end

        ::continue::
        index = index + 1
    end

    return sum
end

function calculate_priority_total_part2(fileName)
    local sum = 0

    local index = 0
    local firstSack = ""
    local secondSack = ""
    local thirdSack = ""
    for line in io.lines(fileName) do
        if index % 3 == 0 then
            if index == 0 then
                firstSack = line
            else
                for i = 1, #firstSack do
                    local char = firstSack:sub(i, i)
                    if string.find(secondSack, char) and string.find(thirdSack, char)
                    then
                        print('Bag', index, ":", PRIORITIES[char])
                        sum = sum + PRIORITIES[char]
                        goto continue
                    end
                end
                ::continue::

                firstSack = line
            end 
        elseif index % 3 == 1 then
            secondSack = line
        else
            thirdSack = line 
        end

        index = index + 1
    end

    -- i'm too lazy to incorporate the last group
    for i = 1, #firstSack do
        local char = firstSack:sub(i, i)
        if string.find(secondSack, char) and string.find(thirdSack, char)
        then
            print('Bag', index, ":", PRIORITIES[char])
            sum = sum + PRIORITIES[char]
            goto continue2
        end
    end
    ::continue2::

    return sum
end

function main()
    local fileName = "input.txt"
    if not file_exists then print("The file doesn't exist:", fileName) return end

    print("The sum of priorities is:", calculate_priority_total(fileName))
    print("The sum of priorities in three-elf groups is:", calculate_priority_total_part2(fileName))
end

main()
