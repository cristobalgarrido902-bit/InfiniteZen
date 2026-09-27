-- ============================================================
-- INFINITE ZEN - LANGUAGE
-- ============================================================

local Language = {}

local currentLanguage = "en"

local translations = {
    en = {
        unsupported_title = "Unsupported Game",
        unsupported_message_pt = "Este jogo ainda não é suportado.",
        unsupported_message_en = "This game is not supported yet.",

        loading = "Loading...",
        loaded = "Loaded",
        error = "Error",
        enabled = "Enabled",
        disabled = "Disabled",

        southbronx = "South Bronx: The Trenches",
    },

    pt = {
        unsupported_title = "Jogo não suportado",
        unsupported_message_pt = "Este jogo ainda não é suportado.",
        unsupported_message_en = "This game is not supported yet.",

        loading = "Carregando...",
        loaded = "Carregado",
        error = "Erro",
        enabled = "Ativado",
        disabled = "Desativado",

        southbronx = "South Bronx: The Trenches",
    },

    es = {
        unsupported_title = "Juego no compatible",
        unsupported_message_pt = "Este juego todavía no es compatible.",
        unsupported_message_en = "This game is not supported yet.",

        loading = "Cargando...",
        loaded = "Cargado",
        error = "Error",
        enabled = "Activado",
        disabled = "Desactivado",

        southbronx = "South Bronx: The Trenches",
    },
}

function Language.setLanguage(language)
    if translations[language] then
        currentLanguage = language
        return true
    end

    warn("[Infinite Zen] Idioma no soportado: " .. tostring(language))
    return false
end

function Language.getLanguage()
    return currentLanguage
end

function Language.get(key)
    local selected = translations[currentLanguage]

    if selected and selected[key] ~= nil then
        return selected[key]
    end

    local english = translations.en

    if english and english[key] ~= nil then
        return english[key]
    end

    return tostring(key)
end

function Language.has(key)
    local selected = translations[currentLanguage]

    return selected ~= nil and selected[key] ~= nil
end

function Language.getTranslations()
    return translations
end

return Language
