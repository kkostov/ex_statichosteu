defmodule ExStatichostEu do
  alias ExStatichostEu.Model.AddSite
  alias ExStatichostEu.Model.Auth

  require Logger

  @moduledoc """
  An official REST API client for `ExStatichostEu`.
  """

  @doc """
    Add a website to your account.

  ## Examples

      iex> auth = %ExStatichostEu.Model.Auth{team_id: "team_id", bearer_token: "bearer_token"}
      iex> add_site = %ExStatichostEu.Model.AddSite{name: "site-name", repository: "ssh://git@....git"}
      iex> {:ok, %{"deploy_key" => deploy_key}} = ExStatichostEu.add_site(auth, add_site)

  """
  def add_site(%Auth{} = auth, %AddSite{} = request) do
    headers = [
      {"Authorization", "Bearer #{auth.bearer_token}"},
      {"Accept", "application/json"}
    ]

    url = "https://builder.statichost.eu/team/#{auth.team_id}/add-site"

    body = request |> Map.from_struct() |> Map.to_list() |> IO.inspect()

    {:ok, resp} =
      Req.post(url, headers: headers, form: body)

    case resp.status do
      200 ->
        # try to parse the body which is JSON encoded as a string
        case Jason.decode(resp.body) do
          {:ok, decoded} ->
            {:ok, decoded}

          {:error, _} ->
            {:ok, resp.body}
        end

      _ ->
        # try to parse the error message which is JSON encoded as a string
        case Jason.decode(resp.body) do
          {:ok, decoded} ->
            {:error, decoded}

          {:error, _} ->
            {:error, resp.body}
        end
    end
  end

  @doc """
    Trigger a build for an existing website. This will deploy the latest changes.

    More information can be found in the [docs](https://www.statichost.eu/docs/webhooks/).

  ## Examples

      iex> {:ok, resp} = ExStatichostEu.trigger_build("test-site")

  """
  def trigger_build(site_name) do
    url = "https://builder.statichost.eu/#{site_name}"

    {:ok, resp} =
      Req.post(url)

    case resp.status do
      200 ->
        {:ok, resp.body}

      _ ->
        {:error, resp.body}
    end
  end
end
