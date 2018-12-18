defmodule AdventOfCode.Day11Test do
  use ExUnit.Case
  alias AdventOfCode.Day11

  describe "execute" do
    test "example_1" do
      input = 8
      point = {3, 5}
    end
  end

  def input() do
    3628
  end

  def example_input_1() do
  end

  test "transform_4" do
    assert Day11.transform_4(949) == 9
    assert Day11.transform_4(49) == 0
    assert Day11.transform_4(1049) == 0
  end

  test "power_level/2" do
    assert Day11.power_level({122, 79}, 57) == -5
    assert Day11.power_level({217, 196}, 39) == 0
    assert Day11.power_level({101, 153}, 71) == 4
  end

  test "process" do
    {:ok, _} = AdventOfCode.Day11.Store.start_link()
    input_1 = input
    size = 300
    sub_grid_size = 3
    grid = Day11.grid(size, input_1)
    a = Day11.process(grid, sub_grid_size)
    assert a == {{216, 12}, 30}
  end
end
