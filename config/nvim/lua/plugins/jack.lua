return {
  { -- helps install lsps, linters, formatters.
    -- but has lots of implicit deps for various lsps (expect to update home.nix too)
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },
  { -- tells mason to manage their installation
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
          ensure_installed = {
            "stylua",
            "shellcheck",
            "shfmt",
            "flake8",
          },
        },
      },
      "neovim/nvim-lspconfig",
    },
  },
  { -- configures lsps for nvim
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
