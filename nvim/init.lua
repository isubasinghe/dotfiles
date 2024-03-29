vim.cmd [[packadd packer.nvim]]
-- vim.opt.number = true
vim.opt.termguicolors=true
vim.opt.expandtab=true
vim.opt.tabstop=2
vim.opt.smartindent=false
vim.opt.shiftwidth=2
vim.opt.softtabstop=2
vim.opt.background='dark'
vim.opt.mouse = 'a'
vim.opt.completeopt='menuone,noselect'

require('packer').init {
  git = {
    clone_timeout = 1024,
  },
}

local use = require('packer').use

require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'folke/lsp-colors.nvim'  
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/vim-vsnip'
  use 'simrat39/rust-tools.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
  -- Lua
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use 'ellisonleao/glow.nvim'
  use 'sbdchd/neoformat'
  use 'b3nj5m1n/kommentary'
  use 'herringtondarkholme/yats.vim'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require'nvim-tree'.setup {
      actions = {
        open_file = {
          quit_on_open = true
        }
      }
    } end
  }
  use 'lervag/vimtex'
  use 'neovimhaskell/nvim-hs.vim'
  use 'kana/vim-textobj-user'
  use 'andy-morris/happy.vim'
  use 'andy-morris/alex.vim'
  use 'neomake/neomake'
  use 'fatih/vim-go'
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use "lukas-reineke/indent-blankline.nvim"
  use "APZelos/blamer.nvim"
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    config = function() 
      require("lsp_lines").setup()
    end,
  }
  use { "beauwilliams/focus.nvim", config = function() require("focus").setup() end }
  use { 'ThePrimeagen/harpoon', requires = 'nvim-lua/plenary.nvim' }
  use 'vim-scripts/promela.vim'
  use 'mfussenegger/nvim-dap'
  use 'airblade/vim-gitgutter'
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'kvrohit/rasmus.nvim'
  use 'B4mbus/oxocarbon-lua.nvim'
  use 'ggandor/leap.nvim'
  use { 'Everblush/everblush.nvim', as = 'everblush' }
  use 'Julian/lean.nvim'
  use {'ShinKage/idris2-nvim', requires = {'neovim/nvim-lspconfig', 'MunifTanjim/nui.nvim'}}
  use 'arkav/lualine-lsp-progress'
  use { 'kartikp10/noctis.nvim', requires = { 'rktjmp/lush.nvim' } }
  use {
    'mrcjkb/haskell-tools.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
    branch = '1.x.x', -- recommended
  }
  use { 'isovector/cornelis', run='stack build' }
end)


-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config({
  virtual_text = false,
})

vim.diagnostic.config({ virtual_lines = true })

vim.g.mapleader =';'
vim.g.go_highlight_functions=1
vim.g.go_highlight_function_calls=1

require'lualine'.setup{
  sections = {
		lualine_c = {
			'lsp_progress'
		}
	}
}



-- Lua
-- vim.cmd[[colorscheme boo]]
-- vim.cmd[[colorscheme kanagawa]]
-- vim.cmd[[colorscheme kuroi]]
-- vim.cmd[[colorscheme rasmus]]
vim.cmd[[colorscheme everblush]]
vim.cmd[[highlight LineNr ctermfg=Grey guifg=Grey]]


local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()


require('nvim-treesitter.configs').setup {
	ensure_installed = { "go", "haskell", "cpp", "c", "rust", "javascript", "typescript" }
}



local nvim_lsp = require('lspconfig')


local other_on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>sy', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

local cmp = require'cmp'

cmp.setup({
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-c>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = function(fallback)
        if cmp.visible() then 
          cmp.select_next_item()
        else 
          fallback()
        end
      end,
      ['<S-Tab'] = function(fallback)
        if cmp.visible() then 
          cmp.select_next_item()
        else 
          fallback()
        end
      end,
    },
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'orgmode' },

      -- For vsnip user.
      -- { name = 'vsnip' },

      -- For luasnip user.
      -- { name = 'luasnip' },

      -- For ultisnips user.
      -- { name = 'ultisnips' },

      { name = 'buffer' },
    }
})


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local servers = {'ocamllsp', 'ccls', 'tsserver', 'pyright', 'texlab', 'gopls', 'terraformls', 'zls', 'verible'}

for _,lsp in ipairs(servers) do 
  nvim_lsp[lsp].setup {
    on_attach = other_on_attach,
    capabilities = capabilities,
  }
end


-- Rust specific config 
local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(param0, bufnr)
      other_on_attach(param0, bufnr)

      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
    capabilities = capabilities,
  },
})

-- Idris2 
require('idris2').setup({server = {on_attach = other_on_attach}})

require('lean').setup{
  abbreviations = { builtin = true },
  lsp = { on_attach = other_on_attach },
  lsp3 = { on_attach = other_on_attach },
  mappings = true,
}

-- treesitter textobjects
require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
      -- You can choose the select mode (default is charwise 'v')
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding xor succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      include_surrounding_whitespace = true,
    },
  },
}


require('leap').set_default_keymaps()

require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    name = "Zsh"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

require('kommentary.config').use_extended_mappings()


-- VimTex 
vim.g.tex_flavor='latex'
vim.g.vimtex_view_method='zathura'
vim.g.vimtex_quickfix_mode=0
vim.api.nvim_command('set conceallevel=2')
vim.g.tex_conceal='abdmg'


vim.api.nvim_set_keymap('', '<space>ff', ':NvimTreeToggle<cr>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('', '<space>gg', ':Neogit<cr>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('', '<space>mk', ':Neomake!<cr>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('', '<space>dd', ':lua require("dapui").toggle()<cr>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('', '<space>rl', ':s/', { silent = true, noremap = true })
vim.api.nvim_set_keymap('', '<space>rg', ':%s/', { silent = true, noremap = true })
vim.api.nvim_set_keymap('', '<space>bp', ':bp<cr>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('', '<space>bn', ':bn<cr>', { silent = true, noremap = true })

vim.api.nvim_set_keymap('', '<leader>br', ':lua require("dap").toggle_breakpoint()<cr>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('', '<leader>cn', ':lua require("dap").continue()<cr>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('', '<leader>so', ':lua require("dap").step_over()<cr>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('', '<leader>si', ':lua require("dap").step_into()<cr>', { silent = true, noremap = true })

vim.api.nvim_set_keymap("", "<space>xx", "<cmd>Trouble<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("", "<space>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("", "<space>xd", "<cmd>Trouble lsp_document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("", "<space>xl", "<cmd>Trouble loclist<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("", "<space>xq", "<cmd>Trouble quickfix<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("", "gR", "<cmd>Trouble lsp_references<cr>",
  {silent = true, noremap = true}
)

vim.api.nvim_set_keymap("", '<space>bk', ':lua require("harpoon.mark").add_file()<cr>',
  {silent = true, noremap = true}
)

vim.api.nvim_set_keymap("", '<space>bkc', ':lua require("harpoon.mark").clear_all()<cr>',
  {silent = true, noremap = true}
)

vim.api.nvim_set_keymap("", '<space>bm', ':lua require("harpoon.ui").toggle_quick_menu()<cr>',
  {silent = true, noremap = true}
)

vim.api.nvim_set_keymap("", '<space>fd', ':FZF<cr>',
  {silent = true, noremap = true}
)

vim.api.nvim_exec([[autocmd FileType haskell nnoremap <buffer> <space>fm :Neoformat! haskell ormolu<cr>]], false)
vim.api.nvim_exec([[autocmd FileType go nnoremap <buffer> <space>fm :Neoformat! go gofumpt<cr>]], false)
vim.api.nvim_exec([[autocmd FileType c nnoremap <buffer> <space>fm :Neoformat! c clang-format<cr>]], false)
vim.api.nvim_exec([[autocmd FileType rust nnoremap <buffer> <space>fm :Neoformat! rust rustfmt<cr>]], false)
vim.api.nvim_exec([[au BufRead,BufNewFile *.cwl setfiletype yaml]], false)


