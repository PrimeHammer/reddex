defmodule Reddex.Links.Create do
  import Sage

  alias Reddex.Links

  def run(link_params) do
    new()
    |> run(:link, &create_link/2)
    |> run(:details, &fetch_details/2)
    |> run(:updated_link, &update_link/2)
    |> transaction(Reddex.Repo, link_params)
  end

  defp create_link(_effects, link_params) do
    Links.create_link(link_params)
  end

  defp fetch_details(_effects, %{"url" => url}) do
    summary = Readability.summarize(url)
    {:ok, %{title: summary.title, description: summary.article_text}}
  end

  defp update_link(%{link: link, details: details}, _link_params) do
    Links.update_link(link, details)
  end
end
