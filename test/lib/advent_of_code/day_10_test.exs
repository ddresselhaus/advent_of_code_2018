defmodule AdventOfCode.Day10Test do
  use ExUnit.Case
  alias AdventOfCode.Day10

  describe "execute" do
    test "works" do
      input_1 = input
      parsed_input = Day10.parse_input(input_1)
      {stars, count} = AdventOfCode.Day10.process(parsed_input)
      # Day10.display_grid(stars) |> IO.inspect(width: 150, limit: :infinity)
      assert count == 10345
    end
  end

  def input() do
    {:ok, stuff} = File.read("./inputs/day10.txt")
    stuff
  end
end
