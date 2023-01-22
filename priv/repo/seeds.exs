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
  Keypress.save_post(
    %Keypress.Schemas.Post{},
    %{
      title: "Some link",
      url: "http://example.com",
      body: "some body once told me"
    },
    publish: true
  )

{:ok, _} =
  Keypress.save_post(
    %Keypress.Schemas.Post{},
    %{
      body: "some tweet like thing or whatever"
    },
    publish: true
  )

{:ok, updated_post} =
  Keypress.save_post(
    %Keypress.Schemas.Post{},
    %{
      title: "Some long",
      body: "lorem ipsum dolor sit amet"
    },
    publish: true
  )

{:ok, _updated_post} = Keypress.save_post(updated_post, %{title: "some long updated"}, publish: true)

{:ok, _} =
  Keypress.save_post(
    %Keypress.Schemas.Post{},
    %{
      title: "Some draft",
      body: "lorem ipsum dolor sit amet"
    },
    publish: false
  )
