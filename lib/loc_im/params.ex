defmodule LocIm.Params do
  def atomize(params) do
    params
    |> Enum.reduce(%{}, fn({k, v}, acc) ->
                          Map.put(acc, String.to_atom(k), v)
                        end) 
  end

  def remove_empty(params) do
    params
    |> Enum.reduce(%{}, fn({k, v}, acc) ->
                          unless is_empty(v) do
                            Map.put(acc, k, v)  
                          else
                            acc
                          end
                        end) 
  end

  def is_empty(val) do
    case val do
      nil -> true
      "" -> true
      _ -> false
    end
  end
end