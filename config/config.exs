import Config

config :ex_statichosteu,
  test_statichost_team: "",
  test_statichost_api_key: ""

import_config "#{Mix.env()}.exs"
