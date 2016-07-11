defmodule MergeData do
  alias RethinkDB.Query

  def merge_files(files) do
    # Merges lists of processed files into one list of maps.
    files = LoadData.process_files(files)
    add_to_bulls_table Enum.concat(files)
  end

  def add_to_bulls_table(list) do
    # Enumerates over the a list of maps and inserts them as JSON documents in RethinkDB.
    Enum.map(list, fn doc ->
      Query.table("bulls")
      |> Query.insert(doc)
      |> SiresDB.run
    end)
  end

end
