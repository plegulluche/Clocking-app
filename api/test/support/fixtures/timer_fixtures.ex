defmodule Api.TimerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Api.Timer` context.
  """

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~U[2022-11-02 15:53:00Z]
      })
      |> Api.Timer.create_clock()

    clock
  end
end
