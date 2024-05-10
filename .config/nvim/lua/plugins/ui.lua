return {
	{
		-- closing buffers will keep window layout
		"moll/vim-bbye",
	},
	{
		-- shows modal with code preview of definition under the cursor
		"rmagatti/goto-preview",
		config = function()
			require('goto-preview').setup({
				height = 20,
				opacity = 5,
			})
		end
	},
	{
		-- shows panel with LSP / diagnostics information on mouse hover
		"soulis-1256/eagle.nvim",
		config = function()
			require("eagle").setup({
				border = "single",
				render_delay = 100,
				window_col = -3,
				window_row = 1,
			})
		end,
	},
	{
		-- shows panel with following operations after pressing a key
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 0
		end,
		opts = {
			window = {
				border = "single",
				margin = { 0, 0, 1, 0 },
				winblend = 10,
			},
		}
	},
	{
		-- notifications engine
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = true, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = true, -- add a border to hover docs and signature help
				},
			})
		end,
	},
	{
		-- file explorer
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				close_if_last_window = false,
			})
		end,
	},
	{
		-- status line on the bottom of the screen
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require('lualine').setup({
				sections = {
					-- not sure why I added this
					-- lualine_b = {
					-- 	{
					-- 		require("noice").api.statusline.mode.get,
					-- 		cond = require("noice").api.statusline.mode.has,
					-- 		color = { fg = "#ff9e64" },
					-- 	}
					-- },
					lualine_c = {
						{
							'filename',
							file_status = true,
							newfile_status = true,
							path = 1,
							shorting_target = 40,
						},
					},
				},
				inactive_sections = {
					lualine_c = {
						{
							'filename',
							file_status = true,
							newfile_status = true,
							path = 1,
							shorting_target = 40,
						},
					},
				},
			})
		end,
	},
	{
		-- shows current buffers at the top of the screen like tabs
		"akinsho/bufferline.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		opts = {
			options = {
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						separator = false,
						text_align = "center"
					},
				},
				mode = "buffers",
				separator_style = "padded_slant",
				always_show_bufferline = true,
				persist_buffer_sort = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				max_name_length = 60,
				name_formatter = function(buf)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf.bufnr), ":p:.")

					filename = vim.fn.pathshorten(filename)

					if vim.bo[buf.bufnr].modified then
						filename = "[+] " .. filename
					end

					return filename
				end,
			},
		},
	},
}
