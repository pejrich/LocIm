defmodule LocIm.PostUploadServer do
  use GenServer

  @server_name :file_upload_server
  @upload_path "priv/static/images/posts/"

  # Run in the client process
  def start_link do
    GenServer.start_link(__MODULE__, nil, name: @server_name)
  end

  def upload(filepath, filename) do
    GenServer.call(@server_name, {:upload, filepath, filename})
  end

  # Run in the server process

  def init(_) do
    initial_id = case File.ls(@upload_path) do
      {:error, :enoent} ->
        File.mkdir_p(@upload_path)
        1
      {:ok, []} -> 1
      {:ok, files} ->
        current = Enum.max_by(files, fn(str) -> String.to_integer(str) end)
        |> String.to_integer
        current + 1
    end
    {:ok, initial_id}
  end

  def handle_call({:upload, filepath, filename}, _from, state) do
    dir_name = @upload_path <> "#{state}/"
    # Create the new directory
    File.mkdir_p(dir_name)
    # Copy original file into directory
    new_filepath = dir_name <> "original." <> ext(filename)
    File.cp(filepath, new_filepath)
    # spawn task to create other versions
    {:reply, asset_path(new_filepath), state + 1}
  end

  defp ext(filename) do
    String.split(filename, ".") |> List.last
  end

  defp asset_path(filepath) do
    String.split(filepath, "priv/static") |> List.last
  end
end