return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"jay-babu/mason-nvim-dap.nvim",
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		require("mason-nvim-dap").setup({
			ensure_installed = { "cppdbg" },
			automatic_installation = true,
			handlers = {
				function(config)
					require("mason-nvim-dap").default_setup(config)
				end,
			},
		})
		require("nvim-dap-virtual-text").setup()

		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()

		-- Auto open/close
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		local augroup = vim.api.nvim_create_augroup("DebuggerConfig", { clear = true })

		vim.api.nvim_create_autocmd("LspAttach", {
			group = augroup,
			callback = function()
				vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Toggle Break" })
				vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
				vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Inspect" })
				vim.keymap.set("n", "<leader>dk", dap.terminate, { desc = "Kill" })

				vim.keymap.set("n", "<leader>dso", dap.step_over, { desc = "Step Over" })
				vim.keymap.set("n", "<leader>dsi", dap.step_into, { desc = "Step Into" })
				vim.keymap.set("n", "<leader>dsu", dap.step_out, { desc = "Step Out" })
				vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run Last" })

				vim.keymap.set("n", "<leader>dut", function()
					dapui.toggle()
				end, { desc = "Toggle DAP UI" })
			end,
		})

		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "cppdbg",
				request = "launch",
				program = function()
					local input = vim.fn.input("Path to executable (you can add args): ", vim.fn.getcwd() .. "")
					local words = vim.split(input, " ")
					-- first word is program, rest are args
					local exe = words[1]
					local args = {}
					if #words > 1 then
						for i = 2, #words do
							table.insert(args, words[i])
						end
					end
					-- save args so dap can see them
					dap.configurations.cpp[1].args = args
					return exe
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = true,
			},
			{
				name = "Attach to gdbserver :1234",
				type = "cppdbg",
				request = "launch",
				MIMode = "gdb",
				miDebuggerServerAddress = "localhost:1234",
				miDebuggerPath = "/usr/bin/gdb",
				cwd = "${workspaceFolder}",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
			},
		}
		dap.configurations.c = dap.configurations.cpp
		dap.configurations.rust = dap.configurations.cpp
	end,
}
