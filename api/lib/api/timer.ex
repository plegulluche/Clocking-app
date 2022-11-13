defmodule Api.Timer do
  @moduledoc """
  The Timer context.
  """

  import Ecto.Query, warn: false
  alias Api.Repo

  alias Api.Timer.Workingtime


  def list_workingtimes(%{"start" => start_date, "end" => end_date, "id" => id}) do
    start_date = convert_iso_date_to_datetime(start_date)
    end_date = convert_iso_date_to_datetime(end_date)

    Workingtime
    |> where([w], w.user_id == ^id)
    |> where([w], w.start_date >= ^start_date)
    |> where([w], w.end_date <= ^end_date)
    |> Repo.all()
  end

  def list_workingtimes(%{"user_id" => id}) do
    Workingtime
    |> where([w], w.user_id == ^id)
    |> Repo.all()
  end
  @doc """
  Returns the list of workingtimes.

  ## Examples

      iex> list_workingtimes()
      [%Workingtime{}, ...]

  """
  def list_workingtimes do
    Repo.all(Workingtime)
  end

  @doc """
  Gets a single workingtime.

  Raises `Ecto.NoResultsError` if the Workingtime does not exist.

  ## Examples

      iex> get_workingtime!(123)
      %Workingtime{}

      iex> get_workingtime!(456)
      ** (Ecto.NoResultsError)

  """
  def get_workingtime!(id), do: Repo.get!(Workingtime, id)

  @doc """
  Creates a workingtime.

  ## Examples

      iex> create_workingtime(%{field: value})
      {:ok, %Workingtime{}}

      iex> create_workingtime(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_workingtime(attrs \\ %{}) do
    %Workingtime{}
    |> Workingtime.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a workingtime.

  ## Examples

      iex> update_workingtime(workingtime, %{field: new_value})
      {:ok, %Workingtime{}}

      iex> update_workingtime(workingtime, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_workingtime(%Workingtime{} = workingtime, attrs) do
    workingtime
    |> Workingtime.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a workingtime.

  ## Examples

      iex> delete_workingtime(workingtime)
      {:ok, %Workingtime{}}

      iex> delete_workingtime(workingtime)
      {:error, %Ecto.Changeset{}}

  """
  def delete_workingtime(%Workingtime{} = workingtime) do
    Repo.delete(workingtime)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking workingtime changes.

  ## Examples

      iex> change_workingtime(workingtime)
      %Ecto.Changeset{data: %Workingtime{}}

  """
  def change_workingtime(%Workingtime{} = workingtime, attrs \\ %{}) do
    Workingtime.changeset(workingtime, attrs)
  end




  def convert_iso_date_to_datetime(date) when not is_nil(date) do
    {:ok, naive_date_time} = Timex.parse(date, "{ISO:Extended:Z}")
    Timex.to_datetime(naive_date_time)
  end

  def convert_iso_date_to_datetime(_), do: nil

  alias Api.Timer.Clock

  @doc """
  Returns the list of clocks.

  ## Examples

      iex> list_clocks()
      [%Clock{}, ...]

  """
  #get all clock filtered by start and end date and a user id
  def list_clocks(%{"start" => start_date, "end" => end_date, "id" => id}) do
    start_date = convert_iso_date_to_datetime(start_date)
    end_date = convert_iso_date_to_datetime(end_date)

    Clock
    |> where([c], c.user_id == ^id)
    |> where([c], c.start_date >= ^start_date)
    |> where([c], c.end_date <= ^end_date)
    |> Repo.all()
  end

  #Get all clocks of a user
  def list_clocks(%{"user_id" => id}) do
    IO.puts "++Inside list clock by user id++"
    Clock
    |> where([c], c.user_id == ^id)
    |> Repo.all()
  end
  @doc """
  Returns the list of workingtimes.

  ## Examples

      iex> list_workingtimes()
      [%Workingtime{}, ...]

  """
  def list_clocks do
    IO.puts "++INSIDE list_clock++"
    IO.inspect(Repo.all(Clock))
    Repo.all(Clock)
  end

  def get_last_two_clocks(%{"user_id" => id}) do
    IO.puts "++INSIDE GET LAST TWO CONTEXT CLOCK++"
    IO.inspect(id)
    Clock
    |> where([c], c.user_id == ^id)
    |> order_by([c], desc: c.inserted_at)
    |> limit(2)
    |> Repo.all()
  end

  @doc """
  Gets a single clock.

  Raises `Ecto.NoResultsError` if the Clock does not exist.

  ## Examples

      iex> get_clock!(123)
      %Clock{}

      iex> get_clock!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clock!(id), do: Repo.get!(Clock, id)



  @doc """
  Creates a clock.

  ## Examples

      iex> create_clock(%{field: value})
      {:ok, %Clock{}}

      iex> create_clock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_clock(attrs \\ %{}) do
    %Clock{}
    |> Clock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a clock.

  ## Examples

      iex> update_clock(clock, %{field: new_value})
      {:ok, %Clock{}}

      iex> update_clock(clock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clock(%Clock{} = clock, attrs) do
    clock
    |> Clock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a clock.

  ## Examples

      iex> delete_clock(clock)
      {:ok, %Clock{}}

      iex> delete_clock(clock)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clock(%Clock{} = clock) do
    Repo.delete(clock)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clock changes.

  ## Examples

      iex> change_clock(clock)
      %Ecto.Changeset{data: %Clock{}}

  """
  def change_clock(%Clock{} = clock, attrs \\ %{}) do
    Clock.changeset(clock, attrs)
  end
end
