defmodule Aoc do
  @moduledoc """
  Documentation for `Aoc`.
  """

  @doc """
  Find 2 numbers in file that sum to 2020 and return their product.
      iex> Aoc.day_1_0()
      633216
  """
  def day_1_0 do
    goal = 2020
    list_of_nums = get_list_of_nums()

    first_num = find_first_partner(list_of_nums, goal)
    first_num * (goal - first_num)
  end

  @doc """
  Find 3 numbers in file that sum to 2020 and return their product.
      iex> Aoc.day_1_1()
      68348924
  """
  def day_1_1 do
    goal = 2020
    list_of_nums = get_list_of_nums()

    # find first number where there exists 2 other numbers that sum to `goal - x`
    first_num = Enum.find(list_of_nums, fn x -> find_first_partner(list_of_nums, goal - x) end)
    second_num = find_first_partner(list_of_nums, goal - first_num)

    first_num * second_num * (goal - first_num - second_num)
  end

  @doc """
  Given a `list` of integers, return the first number in that list which has a
  partner in the list that sums to `goal`.
  """
  def find_first_partner(list, goal) do
    Enum.find(list, fn x -> Enum.member?(list, goal - x) end)
  end

  @doc """
  Count how many passwords match the policy.
      iex> Aoc.day_2_0()
      424
  """
  def day_2_0 do
    get_lines("day2.txt")
    |> Enum.map(&parse_password_policy/1)
    |> Enum.filter(&policy_is_valid?/1)
    |> Enum.count()
  end

  @doc """
  Count how many passwords match the new policy.
      iex> Aoc.day_2_1()
      747
  """
  def day_2_1 do
    get_lines("day2.txt")
    |> Enum.map(&parse_password_policy/1)
    |> Enum.filter(&new_policy_is_valid?/1)
    |> Enum.count()
  end

  def parse_password_policy(policy_password) do
    # example format of policy_password:
    #   2-5 g: qggwcvf
    # should parse to:
    #   %{min: 2, max: 5, letter: g, password: qggwcvf}
    [policy, password] =
      String.split(policy_password, ":")
      |> Enum.map(&String.trim/1)

    [minmax, letter] = String.split(policy, " ")

    [min, max] =
      String.split(minmax, "-")
      |> Enum.map(&String.to_integer/1)

    %{min: min, max: max, letter: letter, password: password}
  end

  @doc """
  Return true if count of occurences of policy.letter in policy.password is between
  policy.min and policy.max inclusive.
  """
  def policy_is_valid?(policy) do
    count =
      String.graphemes(policy.password)
      |> Enum.count(fn letter -> policy.letter == letter end)

    count >= policy.min and count <= policy.max
  end

  @doc """
  Return true if character at 1-based index of policy.min or policy.max into
  policy.password is policy.letter (but only if one of them is the letter, not both).
  """
  def new_policy_is_valid?(policy) do
    letters = String.graphemes(policy.password)
    pos_1 = letters |> Enum.at(policy.min - 1)
    pos_2 = letters |> Enum.at(policy.max - 1)

    Enum.count([pos_1, pos_2], fn letter -> policy.letter == letter end) == 1
  end

  defp get_file(filename) do
    Path.join("data", filename) |> File.read!()
  end

  defp get_list_of_nums do
    # Split into lines, filter out empty lines, convert each to an integer
    get_lines("day1.txt")
    |> Enum.map(&String.to_integer/1)
  end

  defp get_lines(filename) do
    get_file(filename)
    |> String.split("\n")
    |> Enum.filter(fn x -> String.trim(x) != "" end)
  end
end