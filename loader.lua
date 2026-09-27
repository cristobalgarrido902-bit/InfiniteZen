-- ============================================================
-- INFINITE ZEN - MAIN LOADER
-- ============================================================

print("============================================")
print("🌌 INFINITE ZEN HUB")
print("Versão: 2.0")
print("============================================")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local CONFIG = {
    REPO = "https://raw.githubusercontent.com/cristobalgarrido902-bit/InfiniteZen/main",
    DEFAULT_LANG = "en",

    SUPPORTED_GAMES = {
        [286090429] = {name = "Arsenal", module = "arsenal"},
        [14939963714] = {name = "Jailbird", module = "jailbird"},
        [114234929420007] = {name = "BloxStrike", module = "bloxstrike"},
        [8307114974] = {name = "Operation One", module = "OperationOne"},

        -- SOUTH BRONX: THE TRENCHES

        [3734304510] = {
            name = "South Bronx: The Trenches",
            module = "southbronx"
        },

        [10179538382] = {
            name = "South Bronx: The Trenches",
            module = "southbronx"
        },
    }
}

-- ============================================================
-- GAME INFORMATION
-- ============================================================

local placeId = game.PlaceId
local gameId = game.GameId

print("[Infinite Zen] PlaceId:", placeId)
print("[Infinite Zen] GameId:", gameId)

local gameInfo =
    CONFIG.SUPPORTED_GAMES[placeId]
    or CONFIG.SUPPORTED_GAMES[gameId]

-- ============================================================
-- LOAD MODULE
-- ============================================================

local function loadModule(path)

    local cacheBuster =
        "?t=" .. tostring(math.floor(tick() * 1000))

    local url =
        CONFIG.REPO .. "/" .. path .. cacheBuster

    print("[Infinite Zen] Descargando:")
    print(url)

    local success, result = pcall(function()
        return game:HttpGet(url, true)
    end)

    if not success then

        warn(
            "[Infinite Zen] ❌ Error descargando "
            .. path
            .. ": "
            .. tostring(result)
        )

        return nil
    end

    if not result or result == "" then

        warn(
            "[Infinite Zen] ❌ Archivo vacío: "
            .. path
        )

        return nil
    end

    local fn, compileError =
        loadstring(result)

    if not fn then

        warn(
            "[Infinite Zen] ❌ Error de sintaxis en "
            .. path
            .. ": "
            .. tostring(compileError)
        )

        return nil
    end

    return fn
end

-- ============================================================
-- LOAD COMPAT
-- ============================================================

local Compat

do

    local compatLoader =
        loadModule("src/utils/compat.lua")

    if compatLoader then

        local success, result =
            pcall(compatLoader)

        if success and result then

            Compat = result

            print(
                "[Infinite Zen] ✅ Compat cargado"
            )

            if Compat.report then
                pcall(Compat.report)
            end

        else

            warn(
                "[Infinite Zen] ⚠️ Error ejecutando compat.lua"
            )

        end
    end
end

-- ============================================================
-- FALLBACK COMPAT
-- ============================================================

if not Compat then

    warn(
        "[Infinite Zen] ⚠️ Usando Compat fallback"
    )

    Compat = {}

    function Compat.getExecutor()

        if identifyexecutor then

            local success, result =
                pcall(identifyexecutor)

            if success then
                return result
            end
        end

        return "Unknown"
    end

    function Compat.getHWID()

        return tostring(
            LocalPlayer.UserId
        )
    end

    function Compat.mouseClick()

        if mouse1click then
            pcall(mouse1click)
        end
    end

    function Compat.mouseMove(dx, dy)

        if mousemoverel then
            pcall(
                mousemoverel,
                dx,
                dy
            )
        end
    end

    function Compat.fireTouch(
        part1,
        part2,
        toggle
    )

        if firetouchinterest then

            pcall(
                firetouchinterest,
                part1,
                part2,
                toggle
            )

        end
    end

    function Compat.hasDrawing()

        return Drawing ~= nil
    end

    function Compat.report()

        return {}
    end
end

-- ============================================================
-- LOAD UI
-- ============================================================

local UI

do

    local uiLoader =
        loadModule("InfiniteZen_UI.lua")

    if not uiLoader then

        warn(
            "[Infinite Zen] ❌ No se pudo cargar InfiniteZen_UI.lua"
        )

        return
    end

    local success, result =
        pcall(uiLoader)

    if not success then

        warn(
            "[Infinite Zen] ❌ Error ejecutando InfiniteZen_UI.lua: "
            .. tostring(result)
        )

        return
    end

    UI = result

    print(
        "[Infinite Zen] ✅ UI Library cargada"
    )
end

-- ============================================================
-- LOAD LANGUAGE
-- ============================================================

local Language

do

    local languageLoader =
        loadModule(
            "src/utils/language.lua"
        )

    if not languageLoader then

        warn(
            "[Infinite Zen] ❌ No se pudo cargar language.lua"
        )

        return
    end

    local success, result =
        pcall(languageLoader)

    if not success then

        warn(
            "[Infinite Zen] ❌ Error ejecutando language.lua: "
            .. tostring(result)
        )

        return
    end

    Language = result

    if Language.setLanguage then

        Language.setLanguage(
            CONFIG.DEFAULT_LANG
        )

    end

    print(
        "[Infinite Zen] ✅ Language cargado"
    )
end

-- ============================================================
-- UNSUPPORTED GAME
-- ============================================================

if not gameInfo then

    warn(
        "[Infinite Zen] Juego no soportado!"
    )

    warn(
        "[Infinite Zen] PlaceId: "
        .. tostring(placeId)
    )

    warn(
        "[Infinite Zen] GameId: "
        .. tostring(gameId)
    )

    local gui =
        Instance.new("ScreenGui")

    gui.Name =
        "InfiniteZen_Unsupported"

    gui.ResetOnSpawn = false
    gui.Parent = PlayerGui

    local frame =
        Instance.new("Frame")

    frame.Size =
        UDim2.fromOffset(
            420,
            200
        )

    frame.Position =
        UDim2.new(
            0.5,
            -210,
            0.5,
            -100
        )

    frame.BackgroundColor3 =
        Color3.fromRGB(
            14,
            14,
            18
        )

    frame.BorderSizePixel = 0
    frame.Parent = gui

    local corner =
        Instance.new("UICorner")

    corner.CornerRadius =
        UDim.new(
            0,
            12
        )

    corner.Parent = frame

    local stroke =
        Instance.new("UIStroke")

    stroke.Color =
        Color3.fromRGB(
            255,
            70,
            70
        )

    stroke.Thickness = 2
    stroke.Parent = frame

    local title =
        Instance.new("TextLabel")

    title.Size =
        UDim2.new(
            1,
            -40,
            0,
            35
        )

    title.Position =
        UDim2.fromOffset(
            20,
            25
        )

    title.BackgroundTransparency = 1

    title.Text =
        Language.get(
            "unsupported_title"
        )

    title.TextColor3 =
        Color3.fromRGB(
            255,
            70,
            70
        )

    title.TextSize = 20
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    local message =
        Instance.new("TextLabel")

    message.Size =
        UDim2.new(
            1,
            -40,
            0,
            50
        )

    message.Position =
        UDim2.fromOffset(
            20,
            70
        )

    message.BackgroundTransparency = 1

    message.Text =
        "PlaceId: "
        .. tostring(placeId)
        .. "\nGameId: "
        .. tostring(gameId)

    message.TextColor3 =
        Color3.fromRGB(
            220,
            220,
            230
        )

    message.TextSize = 13
    message.Font = Enum.Font.Gotham
    message.Parent = frame

    local closeButton =
        Instance.new("TextButton")

    closeButton.Size =
        UDim2.fromOffset(
            100,
            30
        )

    closeButton.Position =
        UDim2.new(
            0.5,
            -50,
            1,
            -45
        )

    closeButton.BackgroundColor3 =
        Color3.fromRGB(
            255,
            70,
            70
        )

    closeButton.Text = "OK"

    closeButton.TextColor3 =
        Color3.new(
            1,
            1,
            1
        )

    closeButton.TextSize = 14
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = frame

    local buttonCorner =
        Instance.new("UICorner")

    buttonCorner.CornerRadius =
        UDim.new(
            0,
            6
        )

    buttonCorner.Parent =
        closeButton

    closeButton.MouseButton1Click:Connect(
        function()

            gui:Destroy()

        end
    )

    return
end

-- ============================================================
-- GAME FOUND
-- ============================================================

print("============================================")

print(
    "[Infinite Zen] 🎮 Juego detectado: "
    .. gameInfo.name
)

print(
    "[Infinite Zen] 📦 Módulo: "
    .. gameInfo.module
)

print("============================================")

-- ============================================================
-- LOAD GAME MODULE
-- ============================================================

local modulePath =
    "src/games/"
    .. gameInfo.module
    .. ".lua"

local gameLoader =
    loadModule(modulePath)

if not gameLoader then

    warn(
        "[Infinite Zen] ❌ No se pudo cargar "
        .. modulePath
    )

    return
end

local success, gameModule =
    pcall(gameLoader)

if not success then

    warn(
        "[Infinite Zen] ❌ Error ejecutando "
        .. modulePath
        .. ": "
        .. tostring(gameModule)
    )

    return
end

if type(gameModule) ~= "table" then

    warn(
        "[Infinite Zen] ❌ "
        .. modulePath
        .. " no devolvió una tabla"
    )

    return
end

-- ============================================================
-- INITIALIZE GAME
-- ============================================================

if type(gameModule.Init) == "function" then

    local initSuccess, initError =
        pcall(function()

            gameModule.Init({

                Language = Language,

                UI = UI,

                Compat = Compat,

                gameName =
                    gameInfo.name,

                placeId =
                    placeId,

                gameId =
                    gameId,

            })

        end)

    if not initSuccess then

        warn(
            "[Infinite Zen] ❌ Error iniciando "
            .. gameInfo.name
            .. ": "
            .. tostring(initError)
        )

        return
    end
end

print("============================================")

print(
    "[Infinite Zen] ✅ Cargado para: "
    .. gameInfo.name
)

print("============================================")
