return{
    "VPavliashvili/json-nvim",
    config = function()
        vim.keymap.set("n", "<leader>jff", '<cmd>JsonFormatFile<cr>')
        vim.keymap.set("n", "<leader>jmf", '<cmd>JsonMinifyFile<cr>')
    end,
}
