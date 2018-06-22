defmodule Reddex.Links.Create do

  import Sage

  alias Reddex.Links
  alias Reddex.Links.Link

  def run(link_params) do
    new()
    |> run(:link, &create_link/2, &handle_create_errors/4)
    # |> run(:details, &fetch_details/2)
    # |> run(:link_update, &update_link/2)
    |> finally(&acknowledge_job/2)
    |> transaction(Reddex.Repo, link_params)
  end

  defp create_link(_effects, link_params) do
    Links.create_link(link_params)
  end

  defp handle_create_errors(compensate, effects, _failed_stage, link_params) do
    IO.puts "Handle Create Errors"
    IO.inspect compensate
    IO.inspect effects
    IO.inspect link_params
    :abort
  end

  defp fetch_details(effects, %{"url" => url}) do
    IO.puts "Fetch Details"
    IO.inspect effects
    IO.puts "-------------"
    summary = Readability.summarize(url)
    IO.puts summary.title
    {:ok, summary}
  end

  defp update_link(effects, link_params) do
    IO.puts "Update Link"
    IO.inspect effects
    {:ok, link_params}
  end

  defp acknowledge_job(:ok, attrs) do
    IO.puts "Success:"
    IO.inspect attrs
  end

  defp acknowledge_job(error, attrs) do
    IO.puts "Error:"
    IO.inspect error
    IO.inspect attrs
  end
end
