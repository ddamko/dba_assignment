defmodule LoadData do

  def process_files(files) do
    # Gets full path to the file and matches on file extension to determine processing.
    {:ok, path} = File.cwd()
    fullpaths = Enum.map(files, fn(x) -> path <> "/" <> x end)

    Enum.map(fullpaths, fn(x) ->
      cond do
        Regex.match?(~r/.txt/, Path.basename(x)) ->
          process_txt_file(x)
        Regex.match?(~r/.json/, Path.basename(x)) ->
          process_json_file(x)
      end
    end)
  end

  def process_txt_file(file) do
    # Converts text file to a CSV and then joins BREED, COUNTRY and IDNO into a UID field.
    File.stream!(file)
    |> CSV.decode(separator: ?\t, headers: true)
    |> Enum.map(fn row ->
      {uid, _rest} = Map.split(row, ["BREED","COUNTRY","IDNO"])
      new_uid = Map.values(uid) |> Enum.join
      Map.put_new(row, "UID", new_uid)
    end)
  end

  def process_json_file(file) do
    # Converts a JSON file to a Elixir Map, then returns a List of Maps
    {:ok, json} = File.read(file)
    {:ok, map} = Map.fetch(Poison.decode!(json), "results")
    Enum.map(map, fn(x) ->
      for {key, val} <- x, into: %{}, do: {String.upcase(key), val}
    end)
  end

end
