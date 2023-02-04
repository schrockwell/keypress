# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Keypress.Repo.insert!(%Keypress.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

{:ok, _} =
  Keypress.BlogAdmin.save_post(
    %Keypress.Schemas.Post{},
    %{
      type: :link,
      title: "Some link",
      url: "http://example.com",
      body: "some body once told me"
    },
    publish: true
  )

{:ok, _} =
  Keypress.BlogAdmin.save_post(
    %Keypress.Schemas.Post{},
    %{
      type: :short,
      body: "some tweet like thing or whatever"
    },
    publish: true
  )

{:ok, updated_post} =
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
      """
    },
    publish: true
  )

{:ok, _updated_post} = Keypress.BlogAdmin.save_post(updated_post, %{title: "some long updated"}, publish: true)

{:ok, _} =
  Keypress.BlogAdmin.save_post(
    %Keypress.Schemas.Post{},
    %{
      type: :long,
      title: "Some draft",
      body: "lorem ipsum dolor sit amet"
    },
    publish: false
  )
