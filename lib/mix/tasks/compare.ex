defmodule Mix.Tasks.Compare do
  use Mix.Task
  import Logger
  def run(_) do
    Faker.start
    Xip.compare_message_compress |> inspect |> Logger.info
  end
end
