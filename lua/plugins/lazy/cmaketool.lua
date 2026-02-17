return {
	"Civitasv/cmake-tools.nvim",
	config = function()
		local nproc = tonumber(vim.fn.system({ "nproc" }))
		local cmake_build_options = {}
		local cmake_generate_options = {}

		if 0 ~= nproc then
			vim.list_extend(cmake_build_options, { "-j" .. (nproc - 1) })
		end

		if 1 == vim.fn.filereadable("/usr/bin/clang") and 1 == vim.fn.filereadable("/usr/bin/clang++") then
			vim.fn.setenv("CC", "/usr/bin/clang")
			vim.fn.setenv("CXX", "/usr/bin/clang++")
		end

		if 1 == vim.fn.filereadable("/usr/bin/ccache") then
			vim.fn.setenv("CMAKE_C_COMPILER_LAUNCHER", "ccache")
			vim.fn.setenv("CMAKE_CXX_COMPILER_LAUNCHER", "ccache")
		end

		if 1 == vim.fn.filereadable("/usr/bin/ninja") then
			vim.list_extend(cmake_generate_options, { "-G Ninja" })
		end
		local map = vim.keymap.set

		map("n", "<leader>cor", function()
			vim.cmd.CMakeCloseRunner()
			vim.cmd.CMakeOpenRunner()
		end, { desc = "runner" })
		map("n", "<leader>coe", function()
			vim.cmd.CMakeCloseExecutor()
			vim.cmd.CMakeOpenExecutor()
		end, { desc = "executor" })
		map("n", "<leader>coc", function()
			vim.cmd.CMakeCloseCache()
			vim.cmd.CMakeOpenCache()
		end, { desc = "cache" })

		map("n", "<leader>ccR", vim.cmd.CMakeCloseRunner, { desc = "runner" })
		map("n", "<leader>ccE", vim.cmd.CMakeCloseExecutor, { desc = "executor" })
		map("n", "<leader>csR", vim.cmd.CMakeStopRunner, { desc = "runner" })
		map("n", "<leader>csE", vim.cmd.CMakeStopExecutor, { desc = "executor" })

		map("n", "<leader>cB", vim.cmd.CMakeSelectBuildTarget, { desc = "select build target" })
		map("n", "<leader>cL", vim.cmd.CMakeSelectLaunchTarget, { desc = "select launch target" })
		map("n", "<leader>cT", vim.cmd.CMakeSelectBuildType, { desc = "select build type" })

		map("n", "<leader>ccr", function()
			vim.cmd.CMakeStopRunner()
			vim.cmd.CMakeCloseRunner()
		end, { desc = "runner stop and close" })
		map("n", "<leader>cce", function()
			vim.cmd.CMakeStopExecutor()
			vim.cmd.CMakeCloseExecutor()
		end, { desc = "executor stop and close" })

		map("n", "<leader>csr", function()
			vim.cmd.CMakeStopRunner()
			vim.cmd.CMakeCloseRunner()
		end, { desc = "runner stop and close" })
		map("n", "<leader>cse", function()
			vim.cmd.CMakeStopExecutor()
			vim.cmd.CMakeCloseExecutor()
		end, { desc = "executor stop and close" })

		map("n", "<leader>cg", function()
			vim.cmd.CMakeGenerate()
			vim.cmd([[
		" if filereadable("out/compile_commands.json")
		" 	call system ("sleep 2; sed -i 's/-mno-direct-extern-access//g' 'out/compile_commands.json'")
		" endif
	]])
		end, { desc = "cmake generate" })

		map("n", "<leader>cb", function()
			-- vim.cmd.CMakeCloseExecutor ()
			vim.cmd.CMakeBuild()
		end, { desc = "cmake build" })
		map("n", "<leader>cr", function()
			-- vim.cmd.CMakeCloseExecutor ()
			-- vim.cmd.CMakeCloseRunner ()
			vim.cmd.CMakeRun()
		end, { desc = "cmake run" })
		map("n", "<leader>cR", function()
			vim.cmd.CMakeRunCurrentFile()
		end, { desc = "cmake run current" })
		map("n", "<leader>cd", vim.cmd.CMakeDebug, { desc = "cmake debug" })
		map("n", "<leader>cC", vim.cmd.CMakeClean, { desc = "cmake clean" })

		require("cmake-tools").setup({
			cmake_build_options = cmake_build_options,
			cmake_generate_options = cmake_generate_options,
		})
	end,
}
