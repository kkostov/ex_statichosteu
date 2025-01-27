# ExStatichostEu ![Hex.pm Version](https://img.shields.io/hexpm/v/ex_statichosteu) [![Hex Docs](https://img.shields.io/badge/docs-hexpm-blue.svg)](https://hexdocs.pm/ex_statichosteu/)

Unofficial client for the [statichost.eu](https://www.statichost.eu/about/) deployment api.

## Usage

### Adding a new site to a team

```elixir
auth = %ExStatichostEu.Model.Auth{team_id: "team_id", bearer_token: "bearer_token"}

add_site = %ExStatichostEu.Model.AddSite{name: "site-name", repository: "ssh://git@....git"}

{:ok, %{"deploy_key" => deploy_key}} = ExStatichostEu.add_site(auth, add_site)

```

### Trigger a deployment

```elixir
{:ok, resp} = ExStatichostEu.trigger_build("test-site")
```

For more information, please refer to statichost's [documentation](https://www.statichost.eu/docs/).

## Installation

The package can be installed by adding `ex_statichosteu` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_statichosteu, "~> 1.0.1"}
  ]
end
```

## License

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
