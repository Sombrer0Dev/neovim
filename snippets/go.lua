-- As defining all of the snippet-constructors (s, c, t, ...) in every file is rather cumbersome,
-- luasnip will bring some globals into scope for executing these files.
-- defined by snip_env in setup
require('luasnip.loaders.from_lua').lazy_load()
local env = snip_env

return {
  env.s(
    'ff',
    env.fmt(
      [[
      fmt.Println({})
      ]],
      {
        env.i(1, 'text'),
      }
    )
  ),
  env.s(
    'fff',
    env.fmt(
      [[
      fmt.Printf({})
      ]],
      {
        env.i(1, 'text'),
      }
    )
  ),
  env.s(
    'sf',
    env.fmt(
      [[
      fmt.Sprintf({})
      ]],
      {
        env.i(1, 'text'),
      }
    )
  ),
  env.s(
    'ggm',
    env.fmt(
      [[
        //go:generate go run github.com/vektra/mockery/v2@v2.28.2 --name={}
      ]],
      {
        env.i(1, 'name'),
      }
    )
  ),
  env.s(
    'gg',
    env.fmt(
      [[
        //go:generate go run {}
      ]],
      {
        env.i(1, 'package'),
      }
    )
  ),
}
