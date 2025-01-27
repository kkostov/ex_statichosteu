defmodule ExStatichosteuTest do
  use ExUnit.Case, async: false

  test "add existing website to the dashboard" do
    {:ok, %{"deploy_key" => _deploy_key}} =
      ExStatichostEu.add_site(get_auth(), %ExStatichostEu.Model.AddSite{
        name: "test-site",
        repository: get_repo()
      })
  end

  test "deploy changes on demand" do
    {:ok, resp} =
      ExStatichostEu.trigger_build("test-site")
  end

  def get_auth() do
    %ExStatichostEu.Model.Auth{
      team_id: Application.get_env(:ex_statichosteu, :test_statichost_team),
      bearer_token: Application.get_env(:ex_statichosteu, :test_statichost_api_key)
    }
  end

  def get_repo() do
    Application.get_env(:ex_statichosteu, :test_repo)
  end
end
