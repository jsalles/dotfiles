-- brew install ccls
require'lspconfig'.ccls.setup {
  init_options = {
    cache = {
      directory = ".ccls-cache";
    };
  }
}
