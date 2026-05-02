return {
	-- snippet plugin
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	build = "make install_jsregexp",
	dependencies = "rafamadriz/friendly-snippets",
	opts = { history = true, updateevents = "TextChanged,TextChangedI" },
	config = function(_, opts)
		require("luasnip").config.set_config(opts)
		-- vscode format
		require("luasnip.loaders.from_vscode").lazy_load({ exclude = vim.g.vscode_snippets_exclude or {} })
		require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.vscode_snippets_path or "" })

		-- snipmate format
		require("luasnip.loaders.from_snipmate").load()
		require("luasnip.loaders.from_snipmate").lazy_load({ paths = vim.g.snipmate_snippets_path or "" })

		-- lua format
		require("luasnip.loaders.from_lua").load()
		require("luasnip.loaders.from_lua").lazy_load({ paths = vim.g.lua_snippets_path or "" })

		-- fix luasnip #258
		vim.api.nvim_create_autocmd("InsertLeave", {
			callback = function()
				if
					require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
					and not require("luasnip").session.jump_active
				then
					require("luasnip").unlink_current()
				end
			end,
		})

		local ls = require("luasnip")
		ls.filetype_extend("javascript", { "jsdoc" })
		ls.filetype_extend("typescript", { "tsdoc" })
		ls.filetype_extend("javascript", { "jsdoc" })
		ls.filetype_extend("lua", { "luadoc" })
		ls.filetype_extend("python", { "pydoc" })
		ls.filetype_extend("rust", { "rustdoc" })
		ls.filetype_extend("cs", { "csharpdoc" })
		ls.filetype_extend("java", { "javadoc" })
		ls.filetype_extend("c", { "cdoc" })
		ls.filetype_extend("cpp", { "cppdoc" })
		ls.filetype_extend("php", { "phpdoc" })
		ls.filetype_extend("kotlin", { "kdoc" })
		ls.filetype_extend("ruby", { "rdoc" })
		ls.filetype_extend("sh", { "shelldoc" })
		ls.filetype_extend("cpp", { "cppdoc" })
	end,
}
