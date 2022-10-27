defmodule Api.DirectoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Api.Directory` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        username: "some username"
      })
      |> Api.Directory.create_user()

    user
  end

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~N[2022-10-24 14:32:00]
      })
      |> Api.Directory.create_clock()

    clock
  end
end
