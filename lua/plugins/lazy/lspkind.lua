return {
    -- Other plugins...
    {
        "onsails/lspkind.nvim", -- Add lspkind plugin
        event = "VeryLazy",     -- Load lazily during startup
        config = function()
            local lspkind = require("lspkind")
            lspkind.init({
                -- Customize icons for LSP completion items
                symbol_map = {
                    Copilot = "", -- GitHub Copilot icon
                },
            })

            -- Highlight customization for Copilot suggestions
            vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
        end,
    },
}
