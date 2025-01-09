-- ================================================================================
-- * LspConfig (Global (not lang specific) LSP Setup)
-- ================================================================================

--- Foo func
---@param bar string yolo
local function foo(bar)
  print(bar)
end

foo('hello')

return {

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",  -- automatically install LSPs
    },
    event = { "BufReadPre", "BufNewFile" }, -- with BufReadPost, lsp won't automatically attach to buffer
    cmd = { "LspInfo", "LspStart", "LspStop", "LspRestart" },
    opts = {
      inlay_hints = { enabled = true, exclude = {} },
      codelens = { enabled = true },
      diagnostics = {
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        virtual_text = {
          spacing = 4,
          source = 'if_many',
          prefix = "●",
        },
        signs = {
          text = { " ", " ", " ", "󰠠 " },
          numhl = {
            "DiagnosticSignError",
            "DiagnosticSignWarn",
            "DiagnosticSignInfo",
            "DiagnosticSignHint",
          },
        },
      },
      -- Global capabilities
      capabilities = {
        workspace = {
          -- Snacks file rename capabilities
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },
      servers = {
        -- server specific capabilities
      },
      manual_setup = {
        -- lsp server setup manually (or before lspconfig.setup)
        -- e.g. typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
    config = function(_, opts)
      -- dd(opts)

      -- Configure diagnostics
      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      -- FIX: No inlay hints appear
      if opts.inlay_hints.enabled then
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            ---@diagnostic disable-next-line: param-type-mismatch
            if client and client:supports_method("textDocument/inlayHint") then
              if vim.api.nvim_buf_is_valid(args.buf)
                  and vim.bo[args.buf].buftype == ""
                  and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[args.buf].filetype)
              then
                dd('Enabling inlay hints')
                vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
              end
            end
          end
        })
      end

      -- TODO: Configure code lens
      -- if opts.codelens.enabled and vim.lsp.codelens then
      -- end

      -- Compose global lsp server capabilities
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local has_blink, blink = pcall(require, "blink")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        has_blink and blink.get_lsp_capabilities() or {},
        opts.capabilities
      )

      -- dd(capabilities)

      local servers = opts.servers
      local has_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = has_mason and
          vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package) or {}

      --- Function to set up each LSP Server
      ---@param server string
      local function setup_lsp_server(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
          on_attach = opts.on_attach,
        }, servers[server] or {})
        if server_opts.enabled == false then
          return
        end

        if opts.manual_setup[server] then
          -- run manual setup for lsp server
          if opts.manual_setup[server](server, server_opts) then
            return
          end
          -- catchall lsp server setup
        elseif opts.manual_setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- loop through declared servers
      local ensure_installed = {}
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts -- allows `server=true configratuion`
          if server_opts.enabled ~= false then
            -- setup lsp server now if not mason compatible
            if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
              setup_lsp_server(server)
            else -- OR add to list of mason servers to setup later
              ensure_installed[#ensure_installed + 1] = server
            end
          end
        end
      end

      -- Setup mason lsp servers
      if has_mason then
        mlsp.setup({
          automatic_installation = true,
          ensure_installed = ensure_installed,
          handlers = { setup_lsp_server },
        })
      end
    end
  },

}
