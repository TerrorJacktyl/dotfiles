return {
  -- Enable Tailwind's language server to read elm's html syntax
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          filetypes_include = { "elm" },
          -- exclude a filetype from the default_config
          filetypes_exclude = {},
        },
      },
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
    },
  },
}
