-- ~/.config/nvim/lua/plugins/init.lua

return {
    {
        "vyfor/cord.nvim",                         -- Plugin repository
        build = './build || .\\build',            -- Build command for your platform
        event = "VeryLazy",                        -- Load this plugin on VeryLazy event
        config = function()                        -- Configuration function
            require('cord').setup {
                usercmds = true,                  -- Enable user commands
                log_level = 'error',              -- Log level: 'trace', 'debug', 'info', 'warn', 'error', 'off'

                timer = {
                    interval = 1500,              -- Interval between presence updates in milliseconds (min 500)
                    reset_on_idle = false,        -- Reset start timestamp on idle
                    reset_on_change = false,      -- Reset start timestamp on presence change
                },

                editor = {
                    image = "https://i.imgur.com/Ch4ZhJP.png",                  -- Image ID or URL for custom client ID
                    client = 'neovim',            -- Client type: 'vim', 'neovim', 'lunarvim', 'nvchad', 'astronvim' or custom client ID
                    tooltip = 'Neovim v0.10.2', -- Tooltip text when hovering over the editor's image
                },

                display = {
                    show_time = true,             -- Display start timestamp
                    show_repository = true,       -- Show 'View repository' button linked to repository URL, if any
                    show_cursor_position = true, -- Display line and column number of cursor's position
                    swap_fields = true,          -- If enabled, workspace is displayed first
                    swap_icons = false,           -- If enabled, editor is displayed on the main image
                    workspace_blacklist = {},     -- List of workspace names that will hide rich presence
                },

                lsp = {
                    show_problem_count = true,   -- Display number of diagnostics problems
                    severity = 1,                 -- Diagnostic severity: 1=Error, 2=Warning, 3=Info, 4=Hint
                    scope = 'workspace',          -- Scope: 'buffer' or 'workspace'
                },

                idle = {
                    enable = true,                -- Enable idle status
                    show_status = true,           -- Display idle status; disable to hide rich presence on idle
                    timeout = 300000,             -- Timeout in milliseconds after which the idle status is set; 0 to display immediately
                    disable_on_focus = false,     -- Do not display idle status when Neovim is focused
                    text = 'Idle',                -- Text to display when idle
                    tooltip = '💤',               -- Tooltip text when hovering over the idle image
                },

                text = {
                    viewing = 'Viewing {}',       -- Text to display when viewing a read-only file
                    editing = 'Editing {}',       -- Text to display when editing a file
                    file_browser = 'Browsing files in {}',  -- Text to display when browsing files (Empty string to disable)
                    plugin_manager = 'Managing plugins in {}',-- Text to display when managing plugins (Empty string to disable)
                    lsp_manager = 'Configuring LSP in {}',  -- Text to display when managing LSP servers (Empty string to disable)
                    vcs = 'Committing changes in {}',       -- Text to display when using Git or Git-related plugin (Empty string to disable)
                    workspace = 'In {}',          -- Text to display when in a workspace (Empty string to disable)
                },

                buttons = {
                    {
                        label = 'View Repository',  -- Text displayed on the button
                        url = 'git',                -- URL where the button leads ('git' automatically fetches Git repository URL)
                    },
                    -- Uncomment and modify below if you want an additional button
                    -- {
                    --   label = 'View Profile',
                    --   url = 'https://github.com/tr1xem',
                    -- }
                },

--[[                 assets = nil,   ]]                   -- Custom file icons; see the wiki for details

                -- Uncomment and modify below if you want custom assets
                assets = {
                  lazy = {
                    name = 'neovimup',
                    icon = 'https://i.imgur.com/Ch4ZhJP.png',
                    tooltip = 'Neovim v0.10.2',
                    type = 2,
                  },
                  ['cargo.toml'] = 'crates',
                },
            }
        end,
        opts = {},                                 -- Additional options can be passed here if needed
    },
}
