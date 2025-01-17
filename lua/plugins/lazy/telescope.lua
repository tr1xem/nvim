return { {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    config = function()
        require('telescope').setup({
            extensions = {
                fzf = {}
            }
        })

        require('telescope').load_extension('fzf')
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
        vim.keymap.set('n', '<leader>b', function()
            builtin.buffers({ sort_mru = true, ignore_current_buffer = true })
        end)
        vim.keymap.set({ 'n', 'v' }, '<leader>sr', require('telescope.builtin').lsp_references,
            { silent = true, noremap = true })
        vim.keymap.set("n", "<space›en", function()
            require(' telescope.builtin').find_files {
                cwd = vim.fn.stdpath("config") }
        end)
    end
},
    {
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
        }
    }
}
