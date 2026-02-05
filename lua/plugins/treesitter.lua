local function get_lang_treesitter()
    local ok, lang = pcall(require, "lang")
    if not ok then
        return { "lua", "luadoc", "printf", "vim", "vimdoc" }
    end

    local specs = lang.get_specs()
    if not specs.treesitter or vim.tbl_isempty(specs.treesitter) then
        return { "lua", "luadoc", "printf", "vim", "vimdoc" }
    end

    return specs.treesitter
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        opts = function()
            return {
                ensure_installed = get_lang_treesitter(),

                highlight = {
                    enable = true,
                    use_languagetree = true,
                },

                indent = { enable = true },
            }
        end,
    },
}
