defmodule ReadFile do
  @spec getCalories(String.t()) :: nil
  def getCalories(fileName) do
    fileReader(fileName)
  end

  @spec fileReader(String.t()) :: nil
  defp fileReader(fileName) do
    File.read!(fileName)
    |> String.split("\n")
    |> accumulateCalories()
    |> findLargestThreeCalories()
    |> accumulateIntegerCalories()
    |> IO.inspect()
  end

  @spec accumulateIntegerCalories([integer]) :: integer
  defp accumulateIntegerCalories(list) do
    accumulateIntegerCalories(list, 0)
  end

  @spec accumulateIntegerCalories([], integer) :: integer
  defp accumulateIntegerCalories([], acc) do
    acc
  end

  @spec accumulateIntegerCalories([integer | [integer]], integer) :: integer
  defp accumulateIntegerCalories([head | tail], acc) do
    accumulateIntegerCalories(tail, acc + head)
  end

  @spec accumulateCalories([String.t()]) :: [integer]
  defp accumulateCalories(list) do
    accumulateCalories(list, 0, [])
  end

  @spec accumulateCalories([], integer, [integer]) :: [integer]
  defp accumulateCalories([], acc, list) do
    [acc | list]
  end

  @spec accumulateCalories([String.t() | [String.t()]], integer, [integer]) :: [integer]
  defp accumulateCalories([head | tail], acc, list) do
    first_element = String.split(head, "\r") |> List.first()

    if String.length(first_element) == 0 do
      accumulateCalories(tail, 0, [acc | list])
    else
      accumulateCalories(tail, acc + String.to_integer(first_element), list)
    end
  end

  @spec findLargestCalories([integer]) :: integer
  defp findLargestCalories(list) do
    findLargestCalories(list, 0)
  end

  @spec findLargestCalories([], integer) :: integer
  defp findLargestCalories([], largest) do
    largest
  end

  @spec findLargestCalories([integer | [integer]], integer) :: integer
  defp findLargestCalories([head | tail], largest) do
    if head > largest do
      findLargestCalories(tail, head)
    else
      findLargestCalories(tail, largest)
    end
  end

  @spec findLargestCalories([integer]) :: [integer]
  defp findLargestThreeCalories(list) do
    findLargestThreeCalories(list, [0, 0, 0])
  end

  @spec findLargestCalories([], [integer]) :: [integer]
  defp findLargestThreeCalories([], largestCaloriesList) do
    largestCaloriesList
  end

  @spec findLargestCalories([integer | [integer]], [integer]) :: [integer]
  defp findLargestThreeCalories([head | tail], largestCaloriesList) do
    {smallestCalories, smallestCaloriesIndex} = Enum.with_index(largestCaloriesList) |> Enum.min_by(fn {element, _index} -> element end)
    if head > smallestCalories do
      newLargestCaloriesList = List.replace_at(largestCaloriesList, smallestCaloriesIndex, head)
      findLargestThreeCalories(tail, newLargestCaloriesList)
    else
      findLargestThreeCalories(tail, largestCaloriesList)
    end
  end
end

ReadFile.getCalories("calories.txt")
