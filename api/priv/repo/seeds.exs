# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Api.Repo.insert!(%Api.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Api.Account

general_manager = %{
  "email" => "general_manager@e.fr",
  "password" => "super_secret",
  "role" => "general_manager",
  "username" => "General Manager"
}

Account.create_user(general_manager)
