-- https://github.com/AstroNvim/AstroNvim/blob/main/lua/astronvim/plugins/treesitter.lua
-- http://www.lazyvim.org/plugins/treesitter
-- https://ofirgall.github.io/learn-nvim/chapters/05-text-objects.html

-- NOTE: always after editing make sure these don't overlap with the native mappings

-- support:
-- @assignment.inner
-- @assignment.lhs
-- @assignment.outer
-- @assignment.rhs
-- @attribute.inner			CPP-	LUA-	VIM-
-- @attribute.outer			CPP-	LUA-	VIM-
-- @block.inner				CPP-
-- @block.outer
-- @call.inner								VIM-
-- @call.outer
-- @class.inner						LUA-	VIM-
-- @class.outer						LUA-	VIM-
-- @comment.inner			CPP-			VIM-
-- @comment.outer
-- @conditional.inner
-- @conditional.outer
-- @frame.inner				CPP-	LUA-	VIM-
-- @frame.outer				CPP-	LUA-	VIM-
-- @function.inner
-- @function.outer
-- @loop.inner
-- @loop.outer
-- @number.inner
-- @parameter.inner
-- @parameter.outer
-- @regex.inner				CPP-	LUA-
-- @regex.outer				CPP-	LUA-
-- @return.inner
-- @return.outer
-- @scopename.inner			CPP-	LUA-	VIM-
-- @statement.outer

-- native (NVIM v0.11.6):
-- << >> [# [' [( [* [/ [<Space> [A [B [CTRL-L [CTRL-Q [CTRL-T [D [L [M [Q [T [[
-- [] [a [b [d [l [m [q [s [t [{ ]# ]' ]) ]* ]/ ]<Space> ]A ]B ]CTRL-L ]CTRL-Q
-- ]CTRL-T ]D ]L ]M ]Q ]T ][ ]] ]` ]a ]b ]d ]l ]m ]q ]s ]t ]} a" a' a( a) a< a>
-- aB aW a[ a] a` ab ap as at aw a{ a} i" i' i( i) i< i> iB iW i[ i] i` ib ip is
-- it iw i{ i}
--
-- used native keys:
-- " # ' () * / < <Space> > A B CTRL-L CTRL-Q CTRL-T D L M Q T W [ ] ` a b d l m
-- p q s t w { }

-- used native letters:
-- A B CTRL-L CTRL-Q CTRL-T D L M Q T W a b d l m p q s t w
-- used native letters case insensitive:
-- CTRL-L CTRL-Q CTRL-T A B D L M P Q S T W
-- used native symbols:
-- " # ' () * / < <Space> > [ ] ` { }
-- free choices:
-- f F - [f]unction
-- c C - [c]lass 			-- no lua, vim
-- o O - l[o]op
-- k K - bloc[k]			-- cpp no inner
-- i I - cond[i]tional
-- e E - stat[e]ment 		-- no inner
-- r R - pa[r]ameter
-- g G - assi[g]nment (ign)
-- n N - assig[n]ment (ign)
-- u U - return
-- 1 ! - call				-- vim no inner
-- 2 @ - comment			-- cpp, vim no inner

local V1 = {
	enable = true,
	select = {
		enable = true,
		lookahead = true,
		keymaps = {
			["if"] = { query = "@function.inner", desc = "function" },
			["ic"] = { query = "@class.inner", desc = "class" },
			["io"] = { query = "@loop.inner", desc = "loop" },
			["ik"] = { query = "@block.inner", desc = "block" },
			["ii"] = { query = "@conditional.inner", desc = "conditional" },
			["ie"] = { query = "@statement.outer", desc = "statement" },
			["ir"] = { query = "@parameter.inner", desc = "parameter" },
			["ig"] = { query = "@assignment.inner", desc = "assignment" },
			["iu"] = { query = "@return.inner", desc = "return" },
			["i1"] = { query = "@call.inner", desc = "call" },
			["i2"] = { query = "@comment.inner", desc = "comment" },

			["af"] = { query = "@function.outer", desc = "function" },
			["ac"] = { query = "@class.outer", desc = "class" },
			["ao"] = { query = "@loop.outer", desc = "loop" },
			["ak"] = { query = "@block.outer", desc = "block" },
			["ai"] = { query = "@conditional.outer", desc = "conditional" },
			["ae"] = { query = "@statement.outer", desc = "statement" },
			["ar"] = { query = "@parameter.outer", desc = "parameter" },
			["ag"] = { query = "@assignment.outer", desc = "assignment" },
			["au"] = { query = "@return.outer", desc = "return" },
			["a1"] = { query = "@call.outer", desc = "call" },
			["a2"] = { query = "@comment.outer", desc = "comment" },

			["in"] = { query = "@assignment.lhs", desc = "assignment lhs" },
			["iN"] = { query = "@assignment.rhs", desc = "assignment rhs" },
		},
	},
	move = {
		enable = true,
		set_jumps = true,
		goto_next_start = {
			["]f"] = { query = "@function.outer", desc = "function" },
			["]c"] = { query = "@class.outer", desc = "class" },
			["]o"] = { query = "@loop.outer", desc = "loop" },
			["]k"] = { query = "@block.outer", desc = "block" },
			["]i"] = { query = "@conditional.outer", desc = "conditional" },
			["]e"] = { query = "@statement.outer", desc = "statement" },
			["]r"] = { query = "@parameter.outer", desc = "parameter" },
			["]g"] = { query = "@assignment.outer", desc = "assignment" },
			["]u"] = { query = "@return.outer", desc = "return" },
			["]1"] = { query = "@call.outer", desc = "call" },
			["]2"] = { query = "@comment.outer", desc = "comment" },

			["]n"] = { query = "@assignment.lhs", desc = "assignment lhs" },
			["]N"] = { query = "@assignment.rhs", desc = "assignment rhs" },
		},
		goto_next_end = {
			["]F"] = { query = "@function.outer", desc = "function" },
			["]C"] = { query = "@class.outer", desc = "class" },
			["]O"] = { query = "@loop.outer", desc = "loop" },
			["]K"] = { query = "@block.outer", desc = "block" },
			["]I"] = { query = "@conditional.outer", desc = "conditional" },
			["]E"] = { query = "@statement.outer", desc = "statement" },
			["]R"] = { query = "@parameter.outer", desc = "parameter" },
			["]G"] = { query = "@assignment.outer", desc = "assignment" },
			["]U"] = { query = "@return.outer", desc = "return" },
			["]!"] = { query = "@call.outer", desc = "call" },
			["]@"] = { query = "@comment.outer", desc = "comment" },
		},
		goto_previous_start = {
			["[f"] = { query = "@function.outer", desc = "function" },
			["[c"] = { query = "@class.outer", desc = "class" },
			["[o"] = { query = "@loop.outer", desc = "loop" },
			["[k"] = { query = "@block.outer", desc = "block" },
			["[i"] = { query = "@conditional.outer", desc = "conditional" },
			["[e"] = { query = "@statement.outer", desc = "statement" },
			["[r"] = { query = "@parameter.outer", desc = "parameter" },
			["[g"] = { query = "@assignment.outer", desc = "assignment" },
			["[u"] = { query = "@return.outer", desc = "return" },
			["[1"] = { query = "@call.outer", desc = "call" },
			["[2"] = { query = "@comment.outer", desc = "comment" },

			["[n"] = { query = "@assignment.lhs", desc = "assignment lhs" },
			["[N"] = { query = "@assignment.rhs", desc = "assignment rhs" },
		},
		goto_previous_end = {
			["[F"] = { query = "@function.outer", desc = "function" },
			["[C"] = { query = "@class.outer", desc = "class" },
			["[O"] = { query = "@loop.outer", desc = "loop" },
			["[K"] = { query = "@block.outer", desc = "block" },
			["[I"] = { query = "@conditional.outer", desc = "conditional" },
			["[E"] = { query = "@statement.outer", desc = "statement" },
			["[R"] = { query = "@parameter.outer", desc = "parameter" },
			["[G"] = { query = "@assignment.outer", desc = "assignment" },
			["[U"] = { query = "@return.outer", desc = "return" },
			["[!"] = { query = "@call.outer", desc = "call" },
			["[@"] = { query = "@comment.outer", desc = "comment" },
		},
	},
	swap = { -- FIXME: a lot of mappings here don't work, a lot of mappings overlap with native ones:
		enable = true,
		swap_next = {
			[">f"] = { query = "@function.outer", desc = "function" },
			[">c"] = { query = "@class.outer", desc = "class" },
			[">o"] = { query = "@loop.outer", desc = "loop" },
			[">k"] = { query = "@block.outer", desc = "block" },
			[">i"] = { query = "@conditional.outer", desc = "conditional" },
			[">e"] = { query = "@statement.outer", desc = "statement" },
			[">r"] = { query = "@parameter.inner", desc = "parameter" },
			[">g"] = { query = "@assignment.outer", desc = "assignment" },
			[">u"] = { query = "@return.outer", desc = "return" },
			[">1"] = { query = "@call.outer", desc = "call" },
			[">2"] = { query = "@comment.outer", desc = "comment" },

			[">n"] = { query = "@assignment.lhs", desc = "assignment lhs" },
			[">N"] = { query = "@assignment.rhs", desc = "assignment rhs" },
		},
		swap_previous = {
			["<f"] = { query = "@function.outer", desc = "function" },
			["<c"] = { query = "@class.outer", desc = "class" },
			["<o"] = { query = "@loop.outer", desc = "loop" },
			["<k"] = { query = "@block.outer", desc = "block" },
			["<i"] = { query = "@conditional.outer", desc = "conditional" },
			["<e"] = { query = "@statement.outer", desc = "statement" },
			["<r"] = { query = "@parameter.inner", desc = "parameter" },
			["<g"] = { query = "@assignment.outer", desc = "assignment" },
			["<u"] = { query = "@return.outer", desc = "return" },
			["<1"] = { query = "@call.outer", desc = "call" },
			["<2"] = { query = "@comment.outer", desc = "comment" },

			["<n"] = { query = "@assignment.lhs", desc = "assignment lhs" },
			["<N"] = { query = "@assignment.rhs", desc = "assignment rhs" },
		},
	},
}

-- f - function
-- c - class
-- l - loop
-- b - block
-- o - conditional
-- s - statement
-- p - parameter
-- r - return
-- a - call
-- m - comment

local V2 = {
	enable = true,
	select = {
		enable = true,
		lookahead = true,
		keymaps = {
			["<c-i>f"] = { query = "@function.inner", desc = "function" },
			["<c-i>c"] = { query = "@class.inner", desc = "class" },
			["<c-i>o"] = { query = "@loop.inner", desc = "loop" },
			["<c-i>k"] = { query = "@block.inner", desc = "block" },
			["<c-i>i"] = { query = "@conditional.inner", desc = "conditional" },
			["<c-i>e"] = { query = "@statement.outer", desc = "statement" },
			["<c-i>r"] = { query = "@parameter.inner", desc = "parameter" },
			["<c-i>g"] = { query = "@assignment.inner", desc = "assignment" },
			["<c-i>u"] = { query = "@return.inner", desc = "return" },
			["<c-i>1"] = { query = "@call.inner", desc = "call" },
			["<c-i>2"] = { query = "@comment.inner", desc = "comment" },

			["<c-a>f"] = { query = "@function.outer", desc = "function" },
			["<c-a>c"] = { query = "@class.outer", desc = "class" },
			["<c-a>o"] = { query = "@loop.outer", desc = "loop" },
			["<c-a>k"] = { query = "@block.outer", desc = "block" },
			["<c-a>i"] = { query = "@conditional.outer", desc = "conditional" },
			["<c-a>e"] = { query = "@statement.outer", desc = "statement" },
			["<c-a>r"] = { query = "@parameter.outer", desc = "parameter" },
			["<c-a>g"] = { query = "@assignment.outer", desc = "assignment" },
			["<c-a>u"] = { query = "@return.outer", desc = "return" },
			["<c-a>1"] = { query = "@call.outer", desc = "call" },
			["<c-a>2"] = { query = "@comment.outer", desc = "comment" },

			["<c-i>n"] = { query = "@assignment.lhs", desc = "assignment lhs" },
			["<c-i>N"] = { query = "@assignment.rhs", desc = "assignment rhs" },
		},
	},
	move = {
		enable = true,
		set_jumps = true,
		goto_next_start = {
			[" ]f"] = { query = "@function.outer", desc = "function" },
			[" ]c"] = { query = "@class.outer", desc = "class" },
			[" ]o"] = { query = "@loop.outer", desc = "loop" },
			[" ]k"] = { query = "@block.outer", desc = "block" },
			[" ]i"] = { query = "@conditional.outer", desc = "conditional" },
			[" ]e"] = { query = "@statement.outer", desc = "statement" },
			[" ]r"] = { query = "@parameter.outer", desc = "parameter" },
			[" ]g"] = { query = "@assignment.outer", desc = "assignment" },
			[" ]u"] = { query = "@return.outer", desc = "return" },
			[" ]1"] = { query = "@call.outer", desc = "call" },
			[" ]2"] = { query = "@comment.outer", desc = "comment" },

			[" ]n"] = { query = "@assignment.lhs", desc = "assignment lhs" },
			[" ]N"] = { query = "@assignment.rhs", desc = "assignment rhs" },
		},
		goto_next_end = {
			[" ]F"] = { query = "@function.outer", desc = "function" },
			[" ]C"] = { query = "@class.outer", desc = "class" },
			[" ]O"] = { query = "@loop.outer", desc = "loop" },
			[" ]K"] = { query = "@block.outer", desc = "block" },
			[" ]I"] = { query = "@conditional.outer", desc = "conditional" },
			[" ]E"] = { query = "@statement.outer", desc = "statement" },
			[" ]R"] = { query = "@parameter.outer", desc = "parameter" },
			[" ]G"] = { query = "@assignment.outer", desc = "assignment" },
			[" ]U"] = { query = "@return.outer", desc = "return" },
			[" ]!"] = { query = "@call.outer", desc = "call" },
			[" ]@"] = { query = "@comment.outer", desc = "comment" },
		},
		goto_previous_start = {
			[" [f"] = { query = "@function.outer", desc = "function" },
			[" [c"] = { query = "@class.outer", desc = "class" },
			[" [o"] = { query = "@loop.outer", desc = "loop" },
			[" [k"] = { query = "@block.outer", desc = "block" },
			[" [i"] = { query = "@conditional.outer", desc = "conditional" },
			[" [e"] = { query = "@statement.outer", desc = "statement" },
			[" [r"] = { query = "@parameter.outer", desc = "parameter" },
			[" [g"] = { query = "@assignment.outer", desc = "assignment" },
			[" [u"] = { query = "@return.outer", desc = "return" },
			[" [1"] = { query = "@call.outer", desc = "call" },
			[" [2"] = { query = "@comment.outer", desc = "comment" },

			[" [n"] = { query = "@assignment.lhs", desc = "assignment lhs" },
			[" [N"] = { query = "@assignment.rhs", desc = "assignment rhs" },
		},
		goto_previous_end = {
			[" [F"] = { query = "@function.outer", desc = "function" },
			[" [C"] = { query = "@class.outer", desc = "class" },
			[" [O"] = { query = "@loop.outer", desc = "loop" },
			[" [K"] = { query = "@block.outer", desc = "block" },
			[" [I"] = { query = "@conditional.outer", desc = "conditional" },
			[" [E"] = { query = "@statement.outer", desc = "statement" },
			[" [R"] = { query = "@parameter.outer", desc = "parameter" },
			[" [G"] = { query = "@assignment.outer", desc = "assignment" },
			[" [U"] = { query = "@return.outer", desc = "return" },
			[" [!"] = { query = "@call.outer", desc = "call" },
			[" [@"] = { query = "@comment.outer", desc = "comment" },
		},
	},
	swap = { -- FIXME: a lot of mappings here don't work
		enable = true,
		swap_next = {
			[" >f"] = { query = "@function.outer", desc = "function" },
			[" >c"] = { query = "@class.outer", desc = "class" },
			[" >o"] = { query = "@loop.outer", desc = "loop" },
			[" >k"] = { query = "@block.outer", desc = "block" },
			[" >i"] = { query = "@conditional.outer", desc = "conditional" },
			[" >e"] = { query = "@statement.outer", desc = "statement" },
			[" >r"] = { query = "@parameter.inner", desc = "parameter" },
			[" >g"] = { query = "@assignment.outer", desc = "assignment" },
			[" >u"] = { query = "@return.outer", desc = "return" },
			[" >1"] = { query = "@call.outer", desc = "call" },
			[" >2"] = { query = "@comment.outer", desc = "comment" },

			[" >n"] = { query = "@assignment.lhs", desc = "assignment lhs" },
			[" >N"] = { query = "@assignment.rhs", desc = "assignment rhs" },
		},
		swap_previous = {
			[" <f"] = { query = "@function.outer", desc = "function" },
			[" <c"] = { query = "@class.outer", desc = "class" },
			[" <o"] = { query = "@loop.outer", desc = "loop" },
			[" <k"] = { query = "@block.outer", desc = "block" },
			[" <i"] = { query = "@conditional.outer", desc = "conditional" },
			[" <e"] = { query = "@statement.outer", desc = "statement" },
			[" <r"] = { query = "@parameter.inner", desc = "parameter" },
			[" <g"] = { query = "@assignment.outer", desc = "assignment" },
			[" <u"] = { query = "@return.outer", desc = "return" },
			[" <1"] = { query = "@call.outer", desc = "call" },
			[" <2"] = { query = "@comment.outer", desc = "comment" },

			[" <n"] = { query = "@assignment.lhs", desc = "assignment lhs" },
			[" <N"] = { query = "@assignment.rhs", desc = "assignment rhs" },
		},
	},
}

return {
	V1 = V1,
	V2 = V2,
}
