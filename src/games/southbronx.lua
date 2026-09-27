-- ============================================================
-- INFINITE ZEN
-- SOUTH BRONX: THE TRENCHES
-- ============================================================

local SouthBronx = {}

function SouthBronx.Init(Context)

    local UI = Context.UI
    local Compat = Context.Compat
    local Language = Context.Language

    print("============================================")
    print("[South Bronx] Iniciando Infinite Zen...")
    print("[South Bronx] PlaceId:", Context.placeId)
    print("[South Bronx] GameId:", Context.gameId)
    print("============================================")

    -- ========================================================
    -- CHECK UI
    -- ========================================================

    if not UI then
        warn("[South Bronx] ❌ UI no disponible")
        return
    end

    if type(UI.CreateWindow) ~= "function" then
        warn("[South Bronx] ❌ UI.CreateWindow no existe")
        return
    end

    -- ========================================================
    -- CREATE WINDOW
    -- ========================================================

    local Window = UI.CreateWindow({
        Title = "Infinite Zen | South Bronx"
    })

    if not Window then
        warn("[South Bronx] ❌ No se pudo crear la ventana")
        return
    end

    -- ========================================================
    -- INFORMATION
    -- ========================================================

    Window:AddLabel("South Bronx: The Trenches")

    Window:AddLabel(
        "PlaceId: " .. tostring(Context.placeId)
    )

    Window:AddLabel(
        "GameId: " .. tostring(Context.gameId)
    )

    -- ========================================================
    -- TEST BUTTON
    -- ========================================================

    Window:AddButton("Test", function()

        print(
            "[Infinite Zen] South Bronx funciona correctamente"
        )

    end)

    -- ========================================================
    -- CLOSE BUTTON
    -- ========================================================

    Window:AddButton("Cerrar Infinite Zen", function()

        Window:Destroy()

    end)

    -- ========================================================
    -- FINISHED
    -- ========================================================

    print("[South Bronx] ✅ UI creada correctamente")
    print("[South Bronx] ✅ Módulo cargado correctamente")

end

return SouthBronx
