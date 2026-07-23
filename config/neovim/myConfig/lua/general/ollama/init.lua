require('lz.n').load {
  {
    "ollama.nvim",
    cmd = "Ollama",
    after = function()
      require('ollama').setup {
        model = "codellama:7b",
        url = "http://127.0.0.1:11434",
        serve = {
          on_start = false,
          command = "ollama",
          args = { "serve" },
          stop_command = "pkill",
          stop_args = { "-SIGTERM", "ollama" },
        },
        -- View the actual default prompts in ./lua/ollama/prompts.lua
        prompts = {
          Sample_Prompt = {
            prompt = "This is a sample prompt that receives $input and $sel(ection), among others.",
            input_label = "> ",
            model = "llama3.2:1b",
            action = "display",
          }
        }
      }
    end
  }
}
