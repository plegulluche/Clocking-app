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
        time: ~N[2022-10-24 13:04:00]
      })
      |> Api.Directory.create_clock()

    clock
  end

  @doc """
  Generate a workingtime.
  """
  def workingtime_fixture(attrs \\ %{}) do
    {:ok, workingtime} =
      attrs
      |> Enum.into(%{
        end: ~N[2022-10-24 13:05:00],
        start: ~N[2022-10-24 13:05:00]
      })
      |> Api.Directory.create_workingtime()

    workingtime
  end
end
