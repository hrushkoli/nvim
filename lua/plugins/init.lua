-- All plugins have lazy=true by default,to load a plugin on startup just lazy=false
-- List of all default plugins & their definitions
local default_plugins = {
  -- {
  --   "vhyrro/luarocks.nvim",
  --   lazy=false,
  --   priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
  --   opts = {
  --     rocks = { "fzy","magick", "pathlib.nvim ~> 1.0" }, -- specifies a list of rocks to install
  --     -- luarocks_build_args = { "--with-lua=/my/path" }, -- extra options to pass to luarocks's configuration script
  --   },
  -- },

 {
    "leafo/magick",
    -- lazy=false,
      dependencies={
        "vhyrro/luarocks.nvim",
      },
  },

  "nvim-lua/plenary.nvim",

  -- nvchad plugins
  -- { "NvChad/extensions", branch = "v2.0" },

  {
    "NvChad/base46",
    branch = "v2.0",
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  {
    "NvChad/ui",
     lazy=false,
  },

  {
    "NvChad/nvterm",
    init = function()
      require("core.utils").load_mappings "nvterm"
    end,
    config = function(_, opts)
      require "base46.term"
      require("nvterm").setup(opts)
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    init = function()
      require("core.utils").lazy_load "nvim-colorizer.lua"
    end,
    config = function(_, opts)
      require("colorizer").setup(opts)

      -- execute colorizer as soon as possible
      vim.defer_fn(function()
        require("colorizer").attach_to_buffer(0)
      end, 0)
    end,
  },

{
    "nvim-tree/nvim-web-devicons",
    opts = function()
      dofile(vim.g.base46_cache .. "devicons")
      return { override = require "nvchad.icons.devicons" }
    end,
  },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {char = "│", show_trailing_blankline_indent = false},
    },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy=false,
    init = function()
      require("core.utils").lazy_load "nvim-treesitter"
    end,
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "plugins.configs.treesitter"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "syntax")
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "preservim/tagbar"
  },
  {
    "voldikss/vim-browser-search"
  },

  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require("plugins.configs.others").gitsigns
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "git")
      require("gitsigns").setup(opts)
    end,
  },

  -- lsp stuff
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    opts = function()
      return require "plugins.configs.mason"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "mason")
      require("mason").setup(opts)

      -- custom nvchad cmd to install all mason binaries listed
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end, {})

      vim.g.mason_binaries_list = opts.ensure_installed
    end,
  },

  {
    "neovim/nvim-lspconfig",
    -- lazy=false,
    init = function()
      require("core.utils").lazy_load "nvim-lspconfig"
    end,
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },

  -- load luasnips + cmp related in insert mode only
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("plugins.configs.others").luasnip(opts)
        end,

      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },

    opts = function()
      return require "plugins.configs.cmp"
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },

  {
    "numToStr/Comment.nvim",
    -- keys = { "gc", "gb" },
    init = function()
      require("core.utils").load_mappings "comment"
    end,
    config = function()
      require("Comment").setup()
    end,
  },

  -- file managing , picker etc
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    init = function()
      require("core.utils").load_mappings "nvimtree"
    end,
    opts = function()
      return require "plugins.configs.nvimtree"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "nvimtree")
      require("nvim-tree").setup(opts)
      vim.g.nvimtree_side = opts.view.side
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    init = function()
      require("core.utils").load_mappings "telescope"
    end,

    opts = function()
      return require "plugins.configs.telescope"
    end,

    config = function(_, opts)
      dofile(vim.g.base46_cache .. "telescope")
      local telescope = require "telescope"
      telescope.setup(opts)

      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
  },

  -- Only load whichkey after all the gui
  {
    "folke/which-key.nvim",
    -- lazy = false,
    keys = { "<leader>", '"', "'", "`", "c", "v" },
    init = function()
      require("core.utils").load_mappings "whichkey"
    end,
    opts = function()
      return require "plugins.configs.whichkey"
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "whichkey")
      require("which-key").setup(opts)
    end,
  },


    {
        -- see the image.nvim readme for more information about configuring this plugin
        "3rd/image.nvim",
        -- lazy=false,
        dependencies={
          "leafo/magick",
          "vhyrro/luarocks.nvim",
        },
        config = function()
            require("image").setup()
            package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
            package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua"
          end,
        opts = {
            backend = "kitty", -- whatever backend you would like to use
            -- backend = "ueberzugpp", -- whatever backend you would like to use
            max_width = 100,
            max_height = 12,
            max_height_window_percentage = math.huge,
            max_width_window_percentage = math.huge,
            window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        },
        integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
        },
        neorg = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "norg" },
        },
        html = {
          enabled = false,
        },
        css = {
          enabled = false,
        },
      },
    },

  {
      'willothy/wezterm.nvim',
      lazy=false,
  },
  --
  --
  -- {
  --       "benlubas/molten-nvim",
  --       version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
  --       lazy=false,
  --       build = ":UpdateRemotePlugins",
  --       dependencies = { "3rd/image.nvim" },
  --       init = function()
  --           -- these are examples, not defaults. Please see the readme
  --           vim.g.molten_image_provider = "image.nvim"
  --           vim.g.molten_output_win_max_height = 20
  --       end,
  --   },

  -- {
  --   "kiyoon/jupynium.nvim",
  --   build = "pip3 install --user .",
  --   -- build = "conda run --no-capture-output -n jupynium pip install .",
  --   -- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
  -- },
  {
    -- "quarto-dev/quarto-nvim",
    -- lazy=false,
    -- dependencies = {
    --   "jmbuhr/otter.nvim",
    --   "nvim-treesitter/nvim-treesitter",
    --   'willothy/wezterm.nvim',
    -- },
  -- { -- directly open ipynb files as quarto docuements
  --   -- and convert back behind the scenes
  --   'GCBallesteros/jupytext.nvim',
  --   opts = {
  --     custom_language_formatting = {
  --       python = {
  --         extension = 'qmd',
  --         style = 'quarto',
  --         force_ft = 'quarto',
  --       },
  --       r = {
  --         extension = 'qmd',
  --         style = 'quarto',
  --         force_ft = 'quarto',
  --         },
  --       },
  --     },
  --   },

    {
    'benlubas/molten-nvim',
    -- lazy=false,
    dependencies = "willothy/wezterm.nvim",
    init = function()
      vim.g.molten_auto_open_output = false -- cannot be true if molten_image_provider = "wezterm"
      vim.g.molten_output_show_more = true
      vim.g.molten_image_provider = "wezterm"
      vim.g.molten_output_virt_lines = true
      vim.g.molten_split_direction = "right" --direction of the output window, options are "right", "left", "top", "bottom"
      vim.g.molten_split_size = 30 --(0-100) % size of the screen dedicated to the output window
      vim.g.molten_open_cmd = 'wsl-open'
      vim.g.molten_virt_text_output = true
      vim.g.molten_use_border_highlights = true
      vim.g.molten_output_virt_lines = true
      vim.g.molten_virt_lines_off_by_1 = false
      vim.g.molten_auto_image_popup = false
      vim.g.molten_output_win_max_height = 999999
      vim.g.molten_limit_output_chars = 1000000
      vim.g.molten_wrap_output = true
      vim.g.molten_copy_output= true
      vim.g.molten_output_win_border = { "", "━", "", "" }
    end,
    keys = {
      { '<leader>mi', ':MoltenInit<cr>', desc = '[m]olten [i]nit' },
      {
        '<leader>mp',
        ':<C-u>MoltenEvaluateVisual<cr>:MoltenShowOutput<cr>',
        mode = 'v',
        desc = 'molten eval visual',
      },
      {
        '<leader>mv',
        ':<C-u>MoltenEvaluateVisual<cr>',
        mode = 'v',
        desc = 'molten eval visual for Images',
      },
      { '<leader>mr', ':MoltenReevaluateCell<cr>:MoltenShowOutput<cr>', desc = 'molten re-eval cell' },
      { '<leader>mp', ':MoltenEvaluateLine<cr>:MoltenShowOutput<cr>', desc = 'molten evaluate line' },
      { '<leader>ml', ':MoltenEvaluateLine<cr>', desc = 'molten evaluate line (for images)' },
      { '<leader>mj', ':MoltenImagePopup<cr>', desc = 'molten open image popup' },
      { '<leader>mo', ':MoltenShowOutput<cr>', desc = 'molten show output' },
      {"<leader>me", ":noautocmd MoltenEnterOutput<CR>", desc = "show/enter output" },
      {"<C-q>", ":noautocmd MoltenEnterOutput<CR>", desc = "show/enter output" }
    },
  },



  "rcarriga/nvim-notify",   -- optional
  "stevearc/dressing.nvim", -- optional, UI for :JupyniumKernelSelect
  { 'echasnovski/mini.icons', version = false },
  "ErichDonGubler/lsp_lines.nvim",

  },
}

local config = require("core.utils").load_config()



if #config.plugins > 0 then
  table.insert(default_plugins, { import = config.plugins })
end

require("lazy").setup(default_plugins, config.lazy_nvim)
