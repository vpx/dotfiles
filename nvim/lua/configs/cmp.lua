local cmp = require("cmp")

-- Global setup for all filetypes
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = true })
      elseif require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
})

-- Filetype-specific override for LaTeX
cmp.setup.filetype("tex", {
  sources = {
    { name = "luasnip" },  -- snippets
    { name = "omni" },     -- VimTeX completion
    { name = "buffer" },   -- keep buffer fallback
  },
})

