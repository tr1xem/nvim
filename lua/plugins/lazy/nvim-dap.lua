return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"jay-babu/mason-nvim-dap.nvim",
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		-- Signs
		local signs = {
			DapBreakpoint = { text = " ", texthl = "DiagnosticError" },
			DapBreakpointCondition = { text = "󰜁 ", texthl = "DiagnosticWarn" },
			DapBreakpointRejected = { text = " ", texthl = "DiagnosticError" },
			DapLogPoint = { text = "󰍩 ", texthl = "DiagnosticInfo" },
			DapStopped = { text = " ", texthl = "DiagnosticHint", linehl = "Visual" },
		}

		for name, sign in pairs(signs) do
			vim.fn.sign_define(name, sign)
		end
		-- Config
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
				name = "Launch with Picker (Snacks)",
				type = "cppdbg",
				request = "launch",
				cwd = "${workspaceFolder}",
				stopAtEntry = true,

				-- 1. Coroutine pauses DAP until you pick a file
				program = function()
					return coroutine.create(function(dap_run_co)
						local selected_file = nil

						Snacks.picker.files({
							title = "Select Executable (Esc to type manually)",
							cmd = "fd",
							args = { "--type", "x", "--hidden", "--exclude", ".git" },
							layout = { preset = "select" },

							actions = {
								confirm = function(picker, item)
									if item then
										selected_file = item.file
									end
									picker:close()
								end,
							},

							-- on_close guarantees the coroutine resumes even if you press Esc
							on_close = function()
								if selected_file then
									-- The user picked a file from the picker
									coroutine.resume(dap_run_co, selected_file)
								else
									-- The user pressed Esc. Fallback to manual input.
									-- vim.schedule is REQUIRED here so Neovim doesn't glitch
									-- when opening a new prompt immediately after closing the picker.
									vim.schedule(function()
										local path = vim.fn.input({
											prompt = "Manual Path: ",
											default = vim.fn.getcwd() .. "/",
											completion = "file",
										})

										if path and path ~= "" then
											coroutine.resume(dap_run_co, path)
										else
											-- User canceled the manual prompt too, abort DAP
											coroutine.resume(dap_run_co, dap.ABORT)
										end
									end)
								end
							end,
						})
					end)
				end,

				-- 2. Handle args separately and safely
				args = function()
					local input = vim.fn.input("Arguments (leave empty for none): ")
					-- The '1' argument tells vim to respect shell quotes
					return vim.fn.split(input, " ", 1)
				end,
			},
			{
				name = "Attach to gdbserver :1234",
				type = "cppdbg",
				request = "launch",
				MIMode = "gdb",
				miDebuggerServerAddress = "localhost:1234",
				miDebuggerPath = "/usr/bin/gdb",
				cwd = "${workspaceFolder}",
				-- You can apply the exact same coroutine/picker logic here as well
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
			},
		}
		dap.configurations.c = dap.configurations.cpp
		dap.configurations.rust = dap.configurations.cpp
	end,
}
