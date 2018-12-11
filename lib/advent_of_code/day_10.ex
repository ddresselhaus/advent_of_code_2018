defmodule AdventOfCode.Day10 do
  def parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.filter(fn x -> x != "" end)
    |> Enum.map(&capture_line/1)
  end

  def process(input, counter \\ 0) do
    %{height: current_height} = calculate_height(input)
    new_input = Enum.map(input, &transform_to_next_turn/1)
    process(new_input, counter + 1, current_height)
  end

  def process(input, counter, height) do
    new_input = Enum.map(input, &transform_to_next_turn/1)
    %{height: new_height} = calculate_height(new_input)

    case height < new_height do
      true -> {input, counter}
      false -> process(new_input, counter + 1, new_height)
    end
  end

  def transform_to_next_turn(%{pos_x: pos_x, pos_y: pos_y, vel_x: vel_x, vel_y: vel_y}) do
    %{pos_x: pos_x + vel_x, pos_y: pos_y + vel_y, vel_x: vel_x, vel_y: vel_y}
  end

  def capture_line(line) do
    re =
      ~r/\Aposition=<(?<position_1>[\s|\d|-]{6}),\s(?<position_2>[\s|\d|-]{6})\>\svelocity\=<(?<velocity_1>[\d|\s|-]{2}),\s(?<velocity_2>[\d|\s\-]{2})/

    capture = Regex.named_captures(re, line)

    %{
      pos_x: parse_int(capture["position_1"]),
      pos_y: parse_int(capture["position_2"]),
      vel_x: parse_int(capture["velocity_1"]),
      vel_y: parse_int(capture["velocity_2"])
    }
  end

  def parse_int(int) do
    input = String.trim(int)
    {val, _} = Integer.parse(input)
    val
  end

  def display_grid(input) do
    Enum.map(1..250, fn x ->
      Enum.map(1..250, fn y ->
        case exists?(input, x, y) do
          true -> "X"
          false -> "-"
        end
      end)
      |> Enum.join("")
    end)
  end

  def exists?(input, x, y) do
    Enum.any?(input, fn a ->
      a.pos_x == x && a.pos_y == y
    end)
  end

  def calculate_height(input) do
    Enum.reduce(input, %{}, fn %{pos_x: x}, acc ->
      greatest_x = Map.get(acc, :greatest_x, 0)
      least_x = Map.get(acc, :least_x, 0)

      new_greatest =
        case x > greatest_x do
          true -> x
          false -> greatest_x
        end

      new_least =
        case x < least_x do
          true -> x
          false -> least_x
        end

      %{greatest_x: new_greatest, new_least: new_least, height: new_greatest - new_least}
    end)
  end
end
