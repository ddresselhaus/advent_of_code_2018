defmodule AdventOfCode.Day05 do
  def execute(polymer) when is_binary(polymer) do
    String.split(polymer, "")
    |> Enum.filter(fn x -> x != "" end)
    |> react([])
    |> Enum.join()
  end

  def react([], acc), do: Enum.reverse(acc)

  def react([init_head | init_tail], acc = []) do
    react(init_tail, [init_head | acc])
  end

  def react([init_head | init_tail], acc = [acc_head | acc_tail]) when init_head == acc_head do
    react(init_tail, [init_head | acc])
  end

  def react([init_head | init_tail], acc = [acc_head | acc_tail]) do
    case String.upcase(init_head) == String.upcase(acc_head) do
      true -> react(init_tail, acc_tail)
      false -> react(init_tail, [init_head | acc])
    end
  end
end
