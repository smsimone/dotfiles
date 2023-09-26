local lsp = require "lspconfig"
local coq = require "coq" -- add this

--lsp.<server>.setup(<stuff...>)                              -- before
--lsp.<server>.setup(coq.lsp_ensure_capabilities(<stuff...>)) -- after
