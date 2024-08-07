{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  config = mkIf config.nixvim.enable {
    programs.nixvim = {
      plugins = {
        treesitter = enabled;
        fugitive = enabled;
        telescope = enabled;
        gitsigns = enabled;
        noice = enabled;
        floaterm = enabled;

        notify = {
          enable = true;
          topDown = false;
          timeout = 1000;
        };

        bufferline = {
          enable = true;
          mode = "tabs";
        };

        presence-nvim = {
          enable = true;
          autoUpdate = true;
        };

        startup = {
          enable = true;
          theme = "evil";
        };

        lspsaga = {
          enable = true;
        };

        lsp = {
          enable = true;
          servers = {
            clangd = enabled;
            nixd = enabled;
            lua-ls = enabled;
            jsonls = enabled;
            rust-analyzer = {
              enable = true;
              installRustc = true;
              installCargo = true;
            };
          };
          keymaps.lspBuf = {
            K = "hover";
            gD = "references";
            gd = "definition";
            gi = "implementation";
            gy = "type_definition";
          };
        };
        lsp-format = {
          enable = true;
          lspServersToEnable = "all";
        };
        cmp_luasnip = enabled;
        cmp-nvim-lsp = enabled;
        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            window = {
              completion = {
                border = "rounded";
                winhighlight = "FloatBorder:NormalFloat";
              };
              documentation = {
                border = "rounded";
                winhighlight = "FloatBorder:NormalFloat";
              };
            };
            mapping = {
              __raw = ''
                cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'}),
                    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'}),
                  })
              '';
            };
            sources = [
              {
                name = "nvim_lsp";
              }
              {
                name = "path";
              }
              {
                name = "buffer";
              }
              {
                name = "luasnip";
              }
            ];
            formatting = {
              expandable_indicator = true;
              fields = ["abbr" "kind" "menu"];
            };
            snippet = {
              expand = ''
                function(args)
                	require('luasnip').lsp_expand(args.body)
                end
              '';
            };
          }; # settings
        }; # cmp

        lspkind = {
          enable = true;
          mode = "symbol_text";
          preset = "codicons";
          cmp = {
            enable = true;
            after = ''
              function(_, item)
              	item.menu = ""
              	return item
              end
            '';
          };
        };

        luasnip = {
          enable = true;
          extraConfig = {
            enable_autosnippets = true;
            store_selection_keys = "<Tab>";
          };
          fromLua = [
            {paths = "${config.cyanea.user.dotfilesPath}/config/nvim/snippets";}
          ];
        }; #luasnip

        nvim-tree = {
          enable = true;
          autoClose = true;
          autoReloadOnWrite = true;
          git.enable = true;
          updateFocusedFile = lib.enabled;
        };

        lualine = {
          enable = true;
          theme = "auto";
        };

        mini = {
          enable = true;
          modules = {
            pairs = {
              mappings = {
                "\"" = {
                  action = "closeopen";
                  pair = "\"\"";
                  neigh_pattern = "[^\\`].";
                  register = {cr = true;};
                };
              };
            }; # pairs
            animate = {};
          }; # modules
        };

        indent-blankline = {
          enable = true;
          settings = {
            scope = {
              show_end = false;
              show_exact_scope = true;
              show_start = true;
            };
            debounce = 200;
          };
        };

        chatgpt = {
          enable = false;
          settings = {
            show_line_numbers = true;
            api_key_cmd = "echo -n <key-goes-here>";
            extra_curl_params = [
              "-H"
              "Origin: https://example.com"
            ];
          };
        };
      }; # plugins end

      extraPlugins = 
        mkBefore (with pkgs.vimPlugins; with pkgs; [
          {
            plugin = nui-nvim;
          }
          # {
          # 	plugin = hex-nvim;
          # 	config = ''lua require 'hex'.setup()'';
          # }
          {
            plugin = vimUtils.buildVimPlugin {
              name = "leetcode";
              src = fetchFromGitHub {
                owner = "kawre";
                repo = "leetcode.nvim";
                rev = "02fb2c855658ad6b60e43671f6b040c812181a1d";
                hash = "sha256-YoFRd9Uf+Yv4YM6/l7MVLMjfRqhroSS3RCmZvNowIAo=";
              };
            };
            config = ''lua require 'leetcode'.setup() '';
          }
        ]);
    };
  };
}
