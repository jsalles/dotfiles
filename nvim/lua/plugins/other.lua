return {
  'rgroli/other.nvim',
  config = function()
    require("other-nvim").setup({
      rememberBuffers = false,
      mappings = {
        {
          pattern = "src/(.*)/(%a*).test.tsx",
          target = {
            {
              target = "src/%1/%2.tsx",
              context = "implementation"
            },
            {
              target = "src/%1/%2.module.css",
              context = "styles"
            }
          }
        },
        {
          pattern = "src/(.*)/(%a*).tsx",
          target = {
            {
              target = "src/%1/%2.test.tsx",
              context = "tests"
            },
            {
              target = "src/%1/%2.module.css",
              context = "styles"
            }
          }
        },
        {
          pattern = "src/(.*)/(%a*).module.css",
          target = {
            {
              target = "src/%1/%2.tsx",
              context = "implementation"
            },
            {
              target = "src/%1/%2.test.tsx",
              context = "tests"
            }
          }
        },
        {
          pattern = "(.*).cpp",
          target = {
            {
              target = "%1_test.cpp",
              context = "tests",
            },
            {
              target = "%1.h",
              context = "definitions",
            }
          }
        },
        {
          pattern = "(.*)_test.cpp",
          target = {
            {
              target = "%1.cpp",
              context = "implementation",
            },
            {
              target = "%1.h",
              context = "definitions",
            }
          }
        },
        {
          pattern = "(.*).h",
          target = {
            {
              target = "%1_test.cpp",
              context = "tests",
            },
            {
              target = "%1.cpp",
              context = "implementation",
            }
          }
        }
      }
    })
  end,
}
