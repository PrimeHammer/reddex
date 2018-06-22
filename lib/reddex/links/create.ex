defmodule Reddex.Links.Create do
  @moduledoc """
  Creates a Link, Fetches Title and Description and Updates the Link created
  """

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
    try do
      %{title: title, article_text: article_text} = Readability.summarize(url)
      description = article_text_to_description(article_text)
      {:ok, %{title: title, description: description}}
    rescue
      _ -> {:error, "Could not fetch details"}
    end
  end

  defp update_link(%{link: link, details: details}, _link_params) do
    Links.update_link(link, details)
  end

  defp article_text_to_description(article_text) do
    article_text
    |> String.split("\n")
    |> Enum.slice(0..3)
    |> Enum.join()
    |> String.to_charlist()
    |> Enum.take(140)
    |> List.to_string()
  end
end
