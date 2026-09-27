-- ============================================================
-- INFINITE ZEN
-- SOUTH BRONX: THE TRENCHES
-- ============================================================

local SouthBronx = {}

function SouthBronx.Init(Context)
    print("============================================")
    print("🌆 INFINITE ZEN - SOUTH BRONX")
    print("Juego:", Context.gameName)
    print("PlaceId:", Context.placeId)
    print("GameId:", game.GameId)
    print("============================================")

    if Context.UI then
        print("[South Bronx] ✅ UI disponible")
    else
        warn("[South Bronx] ⚠️ UI no disponible")
    end

    if Context.Compat then
        print("[South Bronx] ✅ Compat disponible")
    else
        warn("[South Bronx] ⚠️ Compat no disponible")
    end

    print("[South Bronx] ✅ Módulo cargado correctamente")
end

return SouthBronx
