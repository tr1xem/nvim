return{ "LunarVim/bigfile.nvim",
        event = 'BufReadPre',
    opts = {
filesize = 2, -- size of the fil.
    },
    config = function (_, opts)
    require('bigfile').setup(opts)
    end
}
