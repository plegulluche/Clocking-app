defmodule ApiWeb.WorkingtimeView do
  use ApiWeb, :view
  alias ApiWeb.WorkingtimeView

  def render("index.json", %{workingtimes: workingtimes}) do
    %{data: render_many(workingtimes, WorkingtimeView, "workingtime.json")}
  end

  def render("index2.json", %{workingtimes: workingtimes}) do
    %{data: render_many(workingtimes, WorkingtimeView, "wt_formatted.json")}
  end

  def render("show.json", %{workingtime: workingtime}) do
    %{data: render_one(workingtime, WorkingtimeView, "workingtime.json")}
  end

  def render("workingtime.json", %{workingtime: workingtime}) do
    %{
      id: workingtime.id,
      start: workingtime.start,
      end: workingtime.end,
      user_id: workingtime.user_id
    }
  end

  def render("wt_formatted.json", %{workingtime: workingtime}) do
    %{
      end: workingtime.end,
      start: workingtime.start
    }
  end
end
