-- ============================================================
-- INFINITE ZEN - COMPAT
-- ============================================================

local Compat = {}

function Compat.getExecutor()
    if identifyexecutor then
        local ok, result = pcall(identifyexecutor)
        if ok then
            return result
        end
    end

    return "Unknown"
end

function Compat.getHWID()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    return player and tostring(player.UserId) or "Unknown"
end

function Compat.mouseClick()
    if mouse1click then
        pcall(mouse1click)
    end
end

function Compat.mouseMove(dx, dy)
    if mousemoverel then
        pcall(mousemoverel, dx, dy)
    end
end

function Compat.fireTouch(part1, part2, toggle)
    if firetouchinterest then
        pcall(firetouchinterest, part1, part2, toggle)
    end
end

function Compat.writeFile(path, content)
    if writefile then
        return pcall(writefile, path, content)
    end

    return false
end

function Compat.readFile(path)
    if readfile then
        local ok, result = pcall(readfile, path)

        if ok then
            return result
        end
    end

    return nil
end

function Compat.fileExists(path)
    if isfile then
        local ok, result = pcall(isfile, path)
        return ok and result or false
    end

    return false
end

function Compat.folderExists(path)
    if isfolder then
        local ok, result = pcall(isfolder, path)
        return ok and result or false
    end

    return false
end

function Compat.makeFolder(path)
    if makefolder then
        return pcall(makefolder, path)
    end

    return false
end

function Compat.deleteFile(path)
    if delfile then
        return pcall(delfile, path)
    end

    return false
end

function Compat.listFiles(path)
    if listfiles then
        local ok, result = pcall(listfiles, path)

        if ok then
            return result
        end
    end

    return {}
end

function Compat.setClipboard(text)
    if setclipboard then
        return pcall(setclipboard, text)
    end

    return false
end

function Compat.hasDrawing()
    return Drawing ~= nil
end

function Compat.newDrawing(class, properties)
    if not Drawing then
        return nil
    end

    local drawing = Drawing.new(class)

    if properties then
        for property, value in pairs(properties) do
            drawing[property] = value
        end
    end

    return drawing
end

function Compat.report()
    local report = {
        Executor = Compat.getExecutor(),
        Drawing = Compat.hasDrawing(),
        WriteFile = writefile ~= nil,
        ReadFile = readfile ~= nil,
        SetClipboard = setclipboard ~= nil,
        MouseMove = mousemoverel ~= nil,
        MouseClick = mouse1click ~= nil,
        FireTouch = firetouchinterest ~= nil,
    }

    print("========== INFINITE ZEN COMPAT ==========")

    for name, available in pairs(report) do
        print(name .. ":", available)
    end

    print("=========================================")

    return report
end

return Compat
