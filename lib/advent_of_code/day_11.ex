defmodule AdventOfCode.Day11 do
  alias AdventOfCode.Day11.Store

  def process_part_two(grid, grid_size) do
  end

  def process(grid, sub_grid_size) do
    grid
    |> Enum.map(fn x -> calculate_sub_grid(x, sub_grid_size) end)
    |> Enum.filter(fn {_, x} -> !is_nil(x) end)
    |> Enum.sort_by(&by_power/1)
    |> Enum.reverse()
    |> first
  end

  def first([h | t]), do: h
  def by_power({_, p}), do: p

  def calculate_sub_grid({x, y, power}, sub_grid_size) do
    val =
      Enum.reduce_while(0..(sub_grid_size - 1), 0, fn x_plus, acc ->
        y_total =
          Enum.reduce_while(0..(sub_grid_size - 1), 0, fn y_plus, acc_2 ->
            case read({x + x_plus, y + y_plus}) do
              nil ->
                {:halt, :stop}

              a ->
                {:cont, a + acc_2}
            end
          end)

        case y_total do
          :stop -> {:halt, nil}
          _ -> {:cont, y_total + acc}
        end
      end)

    {{x, y}, val}
  end

  def grid(size, serial_number) do
    Enum.flat_map(1..size, fn x ->
      Enum.map(1..size, fn y ->
        power = power_level({x, y}, serial_number)
        Store.write({{x, y}, power})
        {x, y, power}
      end)
    end)
  end

  def power_level({x, y}, grid_serial_number) do
    rack_id = x + 10

    initial =
      rack_id
      |> transform_1(y)
      |> transform_2(grid_serial_number)
      |> transform_3(rack_id)
      |> transform_4()
      |> transform_5()
  end

  def transform_1(rack_id, y) do
    rack_id * y
  end

  def transform_2(initial, serial_number) do
    initial + serial_number
  end

  def transform_3(initial, rack_id) do
    initial * rack_id
  end

  def transform_4(initial) do
    val = Integer.digits(initial) |> Enum.reverse() |> Enum.at(2)

    case val do
      nil -> 0
      _ -> val
    end
  end

  def transform_5(initial) do
    initial - 5
  end

  def read({x, y}) do
    case :ets.match(:grid, {{x, y}, :"$1"}) do
      [[a]] -> a
      _ -> nil
    end
  end
end
