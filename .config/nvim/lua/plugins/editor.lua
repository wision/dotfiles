return {
	{
		-- yank history in telescope
		"AckslD/nvim-neoclip.lua",
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
		},
		config = function()
			local function is_whitespace(line)
				return vim.fn.match(line, [[^\s*$]]) ~= -1
			end

			local function all(tbl, check)
				for _, entry in ipairs(tbl) do
					if not check(entry) then
						return false
					end
				end
				return true
			end

			require("neoclip").setup({
				on_select = {
					move_to_front = true,
				},
				-- don't store whitespace-only entries
				filter = function(data)
					return not all(data.event.regcontents, is_whitespace)
				end,
			})
		end,
	},
	{
		-- preview markdown files in browser
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		-- highlight the current word under the cursor
		"RRethy/vim-illuminate",
	},
	{
		-- shows vertical lines to indicate the scope/indentation of the current cursor position
		"echasnovski/mini.indentscope",
		config = function()
			require("mini.indentscope").setup({
				symbol = "│",
				options = {
					try_as_border = true,
				},
			})
		end,
	},
	{
		-- session manager
		"coffebar/neovim-project",
		opts = {
			projects = {
				"~/.config/nvim/",
				"~/git/cookielab/*",
				"~/git/million-dollar-ideas/*",
				"~/sbks/*",
			},
			last_session_on_startup = false,
		},
		init = function()
			-- enable saving the state of plugins in the session
			vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
		end,
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim", tag = "0.1.5" },
			{ "Shatur/neovim-session-manager" },
		},
		lazy = false,
		priority = 100,
	},
	{
		-- startup screen
		"goolord/alpha-nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local alpha = require "alpha"
			local dashboard = require("alpha.themes.dashboard")
			local theta = require("alpha.themes.theta")

			table.insert(theta.buttons.val, 6,
				dashboard.button("SPC s l", "☰  List sessions", ":Telescope neovim-project history<CR>"))

			theta.header.val = {
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                     ]],
				[[       ████ ██████           █████      ██                     ]],
				[[      ███████████             █████                             ]],
				[[      █████████ ███████████████████ ███   ███████████   ]],
				[[     █████████  ███    █████████████ █████ ██████████████   ]],
				[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
				[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
				[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
				[[                                                                       ]],
				[[                                                                       ]],
				[[                                                                       ]],
			}

			alpha.setup(theta.config)
		end,
	},
	{
		-- better file explorer & live grep
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			-- ability to open multiple selected files
			local select_one_or_multi = function(prompt_bufnr)
				local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
				local multi = picker:get_multi_selection()

				if not vim.tbl_isempty(multi) then
					require('telescope.actions').close(prompt_bufnr)

					for _, j in pairs(multi) do
						if j.path ~= nil then
							vim.cmd(string.format('%s %s', 'edit', j.path))
						end
					end
				else
					require('telescope.actions').select_default(prompt_bufnr)
				end

				vim.cmd('stopinsert')
			end

			local actions = require("telescope.actions")

			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							['<CR>'] = select_one_or_multi,
							["<C-PageUp>"] = actions.preview_scrolling_up,
							["<C-PageDown>"] = actions.preview_scrolling_down,
						}
					}
				},
				pickers = {
					find_files = {
						find_command = { "rg", "--files", "--hidden", "--sortr", "path" },
					},
					grep_string = {
						additional_args = { "--hidden" },
					},
					live_grep = {
						additional_args = { "--hidden" },
					},
				},
			})
		end,
	},
	{
		-- telescope extension for selecting items
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
	{
		-- better syntax highlighter
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"bash",
					"lua",
					"javascript",
					"markdown_inline",
					"typescript",
					"regex",
					"vimdoc",
				},
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
