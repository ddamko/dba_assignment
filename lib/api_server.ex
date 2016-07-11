defmodule APIServer do
  def start do
    APIServerApp.start(:type,:args)
  end
end
