defmodule Reddex.Links.CreateTest do
  use Reddex.DataCase

  import Mock

  @link_params %{"url" => "some url", "tags_input" => "link"}

  describe "create link" do
    setup_with_mocks([
      {Readability, [],
       [
         summarize: fn _url ->
           %{
             title: "Mocked Title",
             article_text: "Mocked Description"
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

    test "updates title and description" do
      {:ok, _, %{updated_link: link}} = Reddex.Links.Create.run(@link_params)
      assert link.title == "Mocked Title"
      assert link.description == "Mocked Description"
    end
  end

  describe "truncate description" do
    test "truncates to 140 characters" do
      with_mock Readability,
        summarize: fn _url ->
          %{
            title: "Mocked Title",
            article_text: "a\nb\nc\nd\ne\nf"
          }
        end do
        {:ok, _, %{updated_link: link}} = Reddex.Links.Create.run(@link_params)
        assert String.length(link.description) == 5
      end
    end
  end

  describe "readability errors" do
    test "fails gracefully" do
      with_mock Readability,
        summarize: fn _url -> raise "Error" end do
        {:error, message} = Reddex.Links.Create.run(@link_params)
        assert message == "Could not fetch details"
      end
    end
  end
end
