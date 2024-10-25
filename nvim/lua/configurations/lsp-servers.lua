local M = {}
--------------------------------------------------------------------------------
-- DOCS https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/configs
--------------------------------------------------------------------------------
---@class lspConfig
---@field masonName string
---@field masonIgnore boolean

---since nvim-lspconfig and mason.nvim use different package names
---mappings from https://github.com/williamboman/mason-lspconfig.nvim/blob/main/lua/mason-lspconfig/mappings/server.lua
---@type table<string, lspConfig>
local lspToMasonMap = {
	jsonls = { masonName = "json-lsp", masonIgnore = false },
	lua_ls = { masonName = "lua-language-server", masonIgnore = false },
	yamlls = { masonName = "yaml-language-server", masonIgnore = false },
	sqlls = { masonName = "sqlls", masonIgnore = false },
	gopls = { masonName = "gopls", masonIgnore = false },
	dockerls = { masonName = "dockerfile-language-server", masonIgnore = false },
	nil_ls = { masonName = "nil", masonIgnore = false },
	dart = { masonName = "dart", masonIgnore = true },
	clangd = { masonName = 'clangd', masonIgnore = false },
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
	-- "markdown-toc", -- efm
	-- "markdownlint", -- efm
	-- "gopls",
}

---@return string[]
function M.masonDependencies()
	---@type string[]
	local values = {}
	for _, conf in pairs(lspToMasonMap) do
		if not conf.masonIgnore then
			table.insert(values, conf.masonName)
		end
	end
	return vim.list_extend(extraDependencies, values)
end

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
-- SQL
-- DOCS https://github.com/golang/tools/blob/master/gopls/doc/vim.md
M.serverConfigs.sqlls = {
	settings = {
	},
}

--------------------------------------------------------------------------------
-- DOCKER
M.serverConfigs.dockerls = {}

--------------------------------------------------------------------------------
-- NIL
M.serverConfigs.nil_ls = {
	settings = {
		["nil"] = {
			formatting = {
				command = {
					"alejandra"
				}
			}
		}
	},
}

--------------------------------------------------------------------------------
-- DART
M.serverConfigs.dart = {
	cmd = { "dart", "language-server", "--protocol=lsp" },
	filetypes = { "dart" },
	settings = {
		dart = {
			completeFunctionCalls = true,
			showTodos = true,
		},
	}
}

--------------------------------------------------------------------------------
return M
