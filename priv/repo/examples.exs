# Script for populating the database. You can run it as:
#
#     mix run priv/repo/examples.exs

{:ok, :published, _} =
  Keypress.BlogAdmin.save_post(
    %Keypress.Schemas.Post{},
    %{
      type: :link,
      title: "Some link",
      url: "http://example.com",
      body: "some body once told me",
      publish_now: true
    }
  )

{:ok, :published, _} =
  Keypress.BlogAdmin.save_post(
    %Keypress.Schemas.Post{},
    %{
      type: :short,
      body: "some tweet like thing or whatever",
      publish_now: true
    }
  )

{:ok, :published, long_post} =
  Keypress.BlogAdmin.save_post(
    %Keypress.Schemas.Post{},
    %{
      type: :long,
      title: "Some long",
      body: """
      lorem ipsum dolor sit amet

      new paragraph

      ## header 2

      Some **bold** _italic_ text

      and a [link](https://example.com)

      and maybe some `code`

      ```elixir
      def foo(bar) do
        :baz
      end
      ```
      """,
      publish_now: true
    }
  )

{:ok, :updated, _long_post} = Keypress.BlogAdmin.save_post(long_post, %{title: "some long updated", publish_now: true})

{:ok, :draft, _} =
  Keypress.BlogAdmin.save_post(
    %Keypress.Schemas.Post{},
    %{
      type: :long,
      title: "Some draft",
      body: "lorem ipsum dolor sit amet",
      publish_now: false
    }
  )
