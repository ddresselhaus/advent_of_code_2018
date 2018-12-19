defmodule AdventOfCode.Day18Test do
  use ExUnit.Case
  alias AdventOfCode.Day18

  test "transform/1 works" do
    new_area = Day18.transform(test_input, 10)
    points = Day18.points(new_area)
    assert points == 1147
  end

  test "transform/1 works with input" do
    new_area = Day18.transform(input, 10)
    points = Day18.points(new_area)
    assert points == 1147
  end

  @tag timeout: 1_000_000_000
  test "transform/1 works with input, part_two" do
    new_area = Day18.transform(input, 1_000_000_000)
    points = Day18.points(new_area)
    assert points == 1147
  end

  test "transform_ground/1 works" do
    test_1 = [".", ".", ".", ".", ".", ".", ".", "."]
    assert Day18.transform_ground(test_1) == "."
    test_2 = ["|", "|", "|", ".", ".", ".", ".", "."]
    assert Day18.transform_ground(test_2) == "|"
  end

  test "transform_tree/1 works" do
    test_1 = [".", ".", ".", ".", ".", ".", ".", "."]
    assert Day18.transform_tree(test_1) == "|"
    test_2 = ["#", "#", "#", ".", ".", ".", ".", "."]
    assert Day18.transform_tree(test_2) == "#"
  end

  test "transform_lumberyard/1 works" do
    test_1 = [".", ".", ".", ".", ".", ".", ".", "."]
    assert Day18.transform_lumberyard(test_1) == "."
    test_2 = ["#", "|", ".", ".", ".", ".", ".", "."]
    assert Day18.transform_lumberyard(test_2) == "#"
  end

  def test_input do
    """
    .#.#...|#.
    .....#|##|
    .|..|...#.
    ..|#.....#
    #.#|||#|#|
    ...#.||...
    .|....|...
    ||...#|.#|
    |.||||..|.
    ...#.|..|.
    """
  end

  def test_transform_1 do
    """
    .......##.
    ......|###
    .|..|...#.
    ..|#||...#
    ..##||.|#|
    ...#||||..
    ||...|||..
    |||||.||.|
    ||||||||||
    ....||..|.
    """
  end

  def input() do
    {:ok, stuff} = File.read("./inputs/day18.txt")
    stuff
  end
end
