local map = vim.keymap.set

-- 保存 / 退出
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })

-- 更友好的窗口跳转
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- 行首行尾
map({ "n", "v" }, "H", "^", { desc = "Go to line start" })
map({ "n", "v" }, "L", "$", { desc = "Go to line end" })

-- 视觉模式粘贴不污染寄存器
map("v", "p", '"_dP', { desc = "Paste without yanking" })

-- ===== LSP 常用快捷键 =====
local function lsp_map(mode, lhs, rhs, desc)
  map(mode, lhs, rhs, { desc = "LSP: " .. desc, silent = true })
end

-- 跳转 / 信息
lsp_map("n", "gd", vim.lsp.buf.definition, "Goto definition")
lsp_map("n", "gD", vim.lsp.buf.declaration, "Goto declaration")
lsp_map("n", "gi", vim.lsp.buf.implementation, "Goto implementation")
lsp_map("n", "gr", vim.lsp.buf.references, "Goto references")
lsp_map("n", "K", vim.lsp.buf.hover, "Hover doc")

-- 操作
lsp_map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
lsp_map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")

-- 诊断导航
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Diagnostic prev", silent = true })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Diagnostic next", silent = true })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line diagnostics", silent = true })
