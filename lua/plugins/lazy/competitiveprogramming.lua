return {
	{
		"tr1xem/leetcode.nvim", -- Some of my custom tweaks
		build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
		dependencies = {
			-- include a picker of your choice, see picker section for more details
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		cmd = "Leet",
		opts = {
			-- configuration goes here
			image_support = true,
			plugins = {
				non_standalone = true,
			},
		},
	},
	{
		"xeluxee/competitest.nvim",
		dependencies = "MunifTanjim/nui.nvim",
		config = function()
			require("competitest").setup({
				companion_port = 27121,
				receive_print_message = false,
				start_receiving_persistently_on_setup = true,
				template_file = {
					cpp = "~/.config/nvim/competitive-programming/templates/main.cpp",
				},
				evaluate_template_modifiers = true,
				received_files_extension = "cpp",
				received_problems_path = "$(HOME)/personal/Competitive Programming/$(JUDGE)/$(CONTEST)/$(PROBLEM).$(FEXT)",
				received_problems_prompt_path = false,
				received_contests_directory = "$(HOME)/personal/Competitive Programming/$(JUDGE)/$(CONTEST)",
				received_contests_problems_path = "$(PROBLEM)/main.$(FEXT)",
				received_contests_prompt_directory = false,
				received_contests_prompt_extension = false,
			})
		end,
	},
	-- {
	-- 	"dchinmay2/cphelper.nvim",
	-- },
}
