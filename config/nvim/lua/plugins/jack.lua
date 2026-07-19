return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers.tailwindcss = {
        filetypes_exclude = {},
        filetypes_include = { "elm" },
        settings = {
          tailwindCSS = {
            includeLanguages = {
              elm = "html",
            },
            experimental = {
              classRegex = {
                { [[\bclass[\s(<|]+"([^"]*)"]] },
                { [[\bclass[\s(]+"[^"]*"\s+"([^"]*)"]] },
                { [[\bclass[\s<|]+"[^"]*"\s*\+{2}\s*" ([^"]*)"]] },
                { [[\bclass[\s<|]+"[^"]*"\s*\+{2}\s*" [^"]*"\s*\+{2}\s*" ([^"]*)"]] },
                { [[\bclass[\s<|]+"[^"]*"\s*\+{2}\s*" [^"]*"\s*\+{2}\s*" [^"]*"\s*\+{2}\s*" ([^"]*)"]] },
                { [[\bclassList[\s\[\(]+"([^"]*)"]] },
                { [[\bclassList[\s\[\(]+"[^"]*",\s[^\)]+\)[\s\[\(,]+"([^"]*)"]] },
                { [[\bclassList[\s\[\(]+"[^"]*",\s[^\)]+\)[\s\[\(,]+"[^"]*",\s[^\)]+\)[\s\[\(,]+"([^"]*)"]] },
              },
            },
          },
        },
      }

      return opts
    end,
  },
}
