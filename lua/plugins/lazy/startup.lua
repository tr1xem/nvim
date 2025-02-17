return {
    "startup-nvim/startup.nvim",
    verylazy = true,
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope-file-browser.nvim" },
    config = function()
        require "startup".setup({ theme = "dashboard" })
    end
}
