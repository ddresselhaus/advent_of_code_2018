defmodule AdventOfCode.Day05Test do
  use ExUnit.Case
  alias AdventOfCode.Day05

  describe "execute" do
    test "works" do
      input_1 = "aA"
      input_2 = "abBA"
      input_3 = "abAB"
      input_4 = "aabAAB"
      input_5 = "dabAcCaCBAcCcaDA"

      assert Day05.execute(input_1) == ""
      assert Day05.execute(input_2) == ""
      assert Day05.execute(input_3) == "abAB"
      assert Day05.execute(input_4) == "aabAAB"
      assert Day05.execute(input_5) == "dabCBAcaDA"
      input_6 = input
    end
  end

  def input() do
    {:ok, stuff} = File.read("./inputs/day05.txt")
    stuff
  end
end
