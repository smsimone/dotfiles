local M = {}
--------------------------------------------------------------------------------
-- DOCS https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/configs
--------------------------------------------------------------------------------

---since nvim-lspconfig and mason.nvim use different package names
---mappings from https://github.com/williamboman/mason-lspconfig.nvim/blob/main/lua/mason-lspconfig/mappings/server.lua
---@type table<string, string>
local lspToMasonMap = {
	jsonls = "json-lsp",
	lua_ls = "lua-language-server",
	yamlls = "yaml-language-server",
	gopls = "gopls"
}

---@module "lspconfig"
---@type table<string, lspconfig.Config>
M.serverConfigs = {}
for lspName, _ in pairs(lspToMasonMap) do
	M.serverConfigs[lspName] = {}
end

local extraDependencies = {
	"shfmt", -- used by bashls for formatting
	"shellcheck", -- used by bashls/efm for diagnostics, PENDING https://github.com/bash-lsp/bash-language-server/issues/663
	"stylua", -- efm
	"markdown-toc", -- efm
	"markdownlint", -- efm
	"gopls",
}

-- INFO To have the mason-module access this, we cannot return this table, since
-- `lazy.nvim` uses the return values for the plugin spec. Thus we save it in a
-- global variable, so the mason-module can access it.
M.masonDependencies = vim.list_extend(extraDependencies, vim.tbl_values(lspToMasonMap))

--------------------------------------------------------------------------------
-- BASH / ZSH

-- DOCS https://github.com/bash-lsp/bash-language-server/blob/main/server/src/config.ts
-- M.serverConfigs.bashls = {
-- 	filetypes = { "sh", "zsh", "bash" }, -- work in zsh as well
-- 	settings = {
-- 		bashIde = {
-- 			shellcheckPath = "", -- disable while using efm
-- 			shellcheckArguments = "--shell=bash", -- PENDING https://github.com/bash-lsp/bash-language-server/issues/1064
-- 			shfmt = { spaceRedirects = true },
-- 		},
-- 	},
-- }

--------------------------------------------------------------------------------
-- LUA

-- DOCS https://luals.github.io/wiki/settings/
M.serverConfigs.lua_ls = {
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
				keywordSnippet = "Replace",
				showWord = "Disable", -- don't suggest common words as fallback
				workspaceWord = false, -- already done by cmp-buffer
				postfix = "..", -- useful for `table.insert` and the like
			},
			diagnostics = {
				disable = { "trailing-space" }, -- formatter already handles that
			},
			hint = {    -- inlay hints
				enable = true,
				setType = true,
				arrayIndex = "Disable", -- too noisy
				semicolon = "Disable", -- mostly wrong on invalid code
			},
			format = {
				enable = true, -- using `stylua` instead
			},
			-- FIX https://github.com/sumneko/lua-language-server/issues/679#issuecomment-925524834
			workspace = { checkThirdParty = "Disable" },
		},
	},
}

--------------------------------------------------------------------------------
-- JSON & YAML
-- DOCS https://github.com/Microsoft/vscode/tree/main/extensions/json-language-features/server#configuration
M.serverConfigs.jsonls = {
	-- Disable formatting in favor of biome
	init_options = {
		provideFormatter = false,
		documentRangeFormattingProvider = false,
	},
}

-- DOCS https://github.com/redhat-developer/yaml-language-server/tree/main#language-server-settings
M.serverConfigs.yamlls = {
	settings = {
		yaml = {
			format = {
				enable = true,
				printWidth = 100,
				proseWrap = "always",
			},
		},
	},
}

--------------------------------------------------------------------------------
-- GOLANG
-- DOCS https://github.com/golang/tools/blob/master/gopls/doc/vim.md
M.serverConfigs.gopls = {
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			gofumpt = true,
		},
	},
}

--------------------------------------------------------------------------------
return M
