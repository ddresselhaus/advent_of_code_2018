defmodule AdventOfCode.Day18 do
  def solve(input, minutes) do
    transform(input, minutes) |> points
  end

  def points(area) do
    trees = Enum.filter(area, fn {k, v} -> v == "|" end) |> Enum.count()
    lumberyards = Enum.filter(area, fn {k, v} -> v == "#" end) |> Enum.count()

    trees * lumberyards
  end

  def transform(input, minutes) do
    rows = String.split(input, "\n")
    acres = format_rows(rows)

    new_area =
      Enum.reduce(1..minutes, acres, fn x, acc ->
        IO.puts("#{IO.ANSI.cursor_up()}#{IO.ANSI.clear_line()}#{x}")
        transform_area(acc)
      end)
  end

  def transform_area(acres) do
    Enum.reduce(acres, acres, fn {k, v}, acc ->
      neighbors = get_neighbors(k, acres)
      Map.put(acc, k, transform_acre(v, neighbors))
    end)
  end

  def get_neighbors({x, y}, acres) do
    Enum.map(neighbor_coordinates({x, y}), fn {x_pos, y_pos} ->
      Map.get(acres, {x_pos, y_pos})
    end)
  end

  def neighbor_coordinates({x, y}) do
    [
      {x + 1, y - 1},
      {x + 1, y},
      {x + 1, y + 1},
      {x - 1, y - 1},
      {x - 1, y},
      {x - 1, y + 1},
      {x, y - 1},
      {x, y + 1}
    ]
  end

  def format_rows(rows) do
    {_, acres} =
      Enum.reduce(rows, {1, %{}}, fn row, {x_pos, x_acc} ->
        {_, formatted_row} =
          String.split(row, "")
          |> Enum.filter(fn x -> x != "" end)
          |> Enum.reduce({1, x_acc}, fn y_val, {y_pos, y_acc} ->
            {y_pos + 1, Map.put(y_acc, {x_pos, y_pos}, y_val)}
          end)

        {x_pos + 1, formatted_row}
      end)

    acres
  end

  def transform_acre(acre, neighbors) do
    case acre do
      "." -> transform_ground(neighbors)
      "|" -> transform_tree(neighbors)
      "#" -> transform_lumberyard(neighbors)
    end
  end

  def transform_ground(neighbors) do
    trees = Enum.filter(neighbors, fn x -> x == "|" end)

    case Enum.count(trees) >= 3 do
      true -> "|"
      false -> "."
    end
  end

  def transform_tree(neighbors) do
    lumberyards = Enum.filter(neighbors, fn x -> x == "#" end)

    case Enum.count(lumberyards) >= 3 do
      true -> "#"
      false -> "|"
    end
  end

  def transform_lumberyard(neighbors) do
    trees = Enum.filter(neighbors, fn x -> x == "|" end)
    lumberyards = Enum.filter(neighbors, fn x -> x == "#" end)

    case Enum.count(trees) >= 1 && Enum.count(lumberyards) >= 1 do
      true -> "#"
      false -> "."
    end
  end
end
