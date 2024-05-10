local opts = { noremap = true, silent = true }

-- Next / prev buffer
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)
-- Next / prev tab
vim.keymap.set("n", "<C-Tab>", "gt")
vim.keymap.set("n", "<C-S-Tab>", "gT")
-- Move buffer
vim.keymap.set("n", "<C-S-left>", ":BufferLineMovePrev<CR>", opts)
vim.keymap.set("n", "<C-S-right>", ":BufferLineMoveNext<CR>", opts)

-- Delete buffer
vim.keymap.set("n", "<leader>b", ":", { desc = "+Buffer" })
-- vim.keymap.set("n", "<leader>bd", ":bp<bar>sp<bar>bn<bar>bd<CR>", { desc = "Delete buffer" }) -- closes buffer but keeps the window
vim.keymap.set("n", "<leader>bd", ":Bdelete<CR>", { desc = "Delete buffer", silent = true }) -- closes buffer but keeps the window in split

-- Split window
vim.keymap.set("n", "ss", ":split<Return>", opts)
vim.keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
vim.keymap.set("n", "sh", "<C-w>h")
vim.keymap.set("n", "sk", "<C-w>k")
vim.keymap.set("n", "sj", "<C-w>j")
vim.keymap.set("n", "sl", "<C-w>l")

-- Resize window
vim.keymap.set("n", "<C-w><left>", "<C-w><")
vim.keymap.set("n", "<C-w><right>", "<C-w>>")
vim.keymap.set("n", "<C-w><up>", "<C-w>+")
vim.keymap.set("n", "<C-w><down>", "<C-w>-")

-- Select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G")

-- Gitsigns
vim.keymap.set("n", "<leader>g", ":", { desc = "+Git / Grep" })
vim.keymap.set("n", "<leader>gh", function() require("gitsigns").blame_line { full = true } end, { desc = "Show git blame hunk" })
vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "Show git blame" })

vim.keymap.set("n", "<leader>s", ":", { desc = "Sessions" })
vim.keymap.set("n", "<leader>sl", ":Telescope neovim-project history<CR>", { desc = "Show session/projects list" })

-- Always sort files by path
vim.keymap.set("n", "<leader><space>", "<CMD>lua require'telescope-config'.project_files()<CR>", { desc = "Browse files" })
--vim.keymap.set("n", "<leader> ", require("telescope.builtin").git_files, { desc = "Git files" })
vim.keymap.set("n", "<leader>f", require("telescope.builtin").find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>/", require("telescope.builtin").live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>gs", require("telescope.builtin").grep_string, { desc = "Grep string" })

-- neo-tree
vim.keymap.set("n", "<leader>e", ":Neotree filesystem reveal left<CR>", opts)

-- lsp
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "gh", vim.lsp.buf.hover, { desc = "Show hover" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to next diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename object" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.setloclist, { desc = "Show diagnostic list" })

vim.keymap.set({ "n", "v" }, "<leader>c", ":", { desc = "+Code" })
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set({ "n", "v" }, "<leader>cf", vim.lsp.buf.format, { desc = "LSP Code format" })
vim.keymap.set({ "n", "v" }, "<leader>ce", ":EslintFixAll<CR>", { desc = "Eslint format" })

-- disable search highlight on ESC
vim.keymap.set("n", "<Esc>", function() vim.cmd("noh") end, opts)

-- Goto-preview - opens a floating window with the definition
vim.keymap.set("n", "gp", ":", { desc = "+Goto Preview" })
vim.keymap.set("n", "gpd", require("goto-preview").goto_preview_definition, { desc = "Goto definition" })
vim.keymap.set("n", "gpt", require("goto-preview").goto_preview_type_definition, { desc = "Goto type definition" })
vim.keymap.set("n", "gpi", require("goto-preview").goto_preview_implementation, { desc = "Goto implementation" })
vim.keymap.set("n", "gpD", require("goto-preview").goto_preview_declaration, { desc = "Goto declaration" })
vim.keymap.set("n", "gP", require("goto-preview").close_all_win, { desc = "Close all preview windows" })
vim.keymap.set("n", "gpr", require("goto-preview").goto_preview_references, { desc = "Goto references" })

-- Markdown preview
vim.keymap.set("n", "<leader>p", ":MarkdownPreviewToggle<CR>", { desc = "Markdown preview toggle", silent = true })

-- Check neovim health
vim.keymap.set("n", "<leader>h", ":checkhealth<CR>", { desc = "Show vim healthcheck", silent = true })

-- Yank history
vim.keymap.set("n", "<leader>y", ":Telescope neoclip<CR>", { desc = "Show yank history" })
