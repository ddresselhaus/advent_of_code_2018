defmodule AdventOfCode.Day07Test do
  use ExUnit.Case
  alias AdventOfCode.Day07

  describe "execute" do
    test "works" do
      input_1 = input
      input_3 = input_3
      input_2 = input_2
      b = Day07.parse_input(input_2)
      c = Day07.capture_line(input_3)
    end
  end

  def input_3 do
    "Step C must be finished before step A can begin."
  end

  def input_2 do
    """
    Step C must be finished before step A can begin.
    Step C must be finished before step F can begin.
    Step A must be finished before step B can begin.
    Step A must be finished before step D can begin.
    Step B must be finished before step E can begin.
    Step D must be finished before step E can begin.
    Step F must be finished before step E can begin.
    """
  end

  def input() do
    {:ok, stuff} = File.read("./inputs/day07.txt")
    stuff
  end
end
