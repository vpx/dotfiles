local g = vim.g

g.vimtex_view_method = 'zathura'
g.vimtex_compiler_method = 'latexmk'
g.vimtex_quickfix_mode = 0
g.vimtex_complete_enabled = 1
g.vimtex_complete_close_braces = 1
g.vimtex_syntax_enabled = 1

vim.g.vimtex_compiler_latexmk = {
    aux_dir = vim.fn.getcwd() .. "/build",
    out_dir = vim.fn.getcwd() .. "/build",
}

return g;
