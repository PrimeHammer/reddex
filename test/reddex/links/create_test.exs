defmodule Reddex.Links.CreateTest do
  use Reddex.DataCase

  import Mock

  describe "create link" do
    @link_params %{"url" => "some url", "tags_input" => "link"}

    setup_with_mocks([
      {Readability, [],
       [
         summarize: fn _url ->
           %{
             title: "Mocked Title",
             description: "Mocked Description"
           }
         end
       ]}
    ]) do
      :ok
    end

    test "fethes title and description" do
      {:ok, _, %{details: details}} = Reddex.Links.Create.run(@link_params)
      assert details.title == "Mocked Title"
      assert details.description == "Mocked Description"
    end
  end
end
