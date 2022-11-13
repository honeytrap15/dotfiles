-- install packer
local install_path = vim.fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

-- set built-in option
vim.opt.number = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.autoindent = true
vim.opt.clipboard = vim.opt.clipboard + 'unnamed'
vim.opt.hlsearch = true
vim.opt.expandtab = true
vim.opt.swapfile = true
vim.opt.directory = vim.env.HOME .. "/nvim/swap"
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.backup = false
vim.opt.undofile = false
vim.opt.list = true
vim.opt.listchars = "tab:»-,trail:.,eol:↲,extends:»,precedes:«,nbsp:%"
vim.opt.termguicolors = true

-- keybind
vim.keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR><Esc>')
vim.keymap.set('n', '<C-p>', ':Isort<CR>')
vim.keymap.set('n', '<C-n>', ':NERDTreeFocus<CR>')
vim.keymap.set('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>')

-- plugins
require("packer").startup(function(use)
  -- lsp
  use "wbthomason/packer.nvim"
  use "neovim/nvim-lspconfig"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"

  -- completion
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-vsnip"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/vim-vsnip"

  -- common
  use "cocopon/iceberg.vim"
  use "scrooloose/nerdtree"
  use "Xuyuanp/nerdtree-git-plugin"
  use "vim-airline/vim-airline"
  use "vim-airline/vim-airline-themes"
  use "sheerun/vim-polyglot"

  if packer_bootstrap then
    require("packer").sync()
  end
end)
vim.cmd([[autocmd BufWritePost init.lua source <afile> | PackerCompile]])

-- api
vim.api.nvim_command [[colorscheme iceberg]]

-- mason
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {
      on_attach = on_attach
    }
  end,
}

-- completion
vim.opt.completeopt = "menu,menuone,noselect"
local cmp = require"cmp"
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "vsnip" },
  }, {
    { name = "buffer" },
  })
})
