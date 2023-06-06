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

  defp accumulateIntegerCalories(list) do
    accumulateIntegerCalories(list, 0)
  end

  defp accumulateIntegerCalories([], acc) do
    acc
  end

  defp accumulateIntegerCalories([head | tail], acc) do
    accumulateIntegerCalories(tail, acc + head)
  end

  defp accumulateCalories(list) do
    accumulateCalories(list, 0, [])
  end

  defp accumulateCalories([], acc, list) do
    [acc | list]
  end

  defp accumulateCalories([head | tail], acc, list) do
    first_element = String.split(head, "\r") |> List.first()

    if String.length(first_element) == 0 do
      accumulateCalories(tail, 0, [acc | list])
    else
      accumulateCalories(tail, acc + String.to_integer(first_element), list)
    end
  end

  defp findLargestCalories(list) do
    findLargestCalories(list, 0)
  end

  defp findLargestCalories([], largest) do
    largest
  end

  defp findLargestCalories([head | tail], largest) do
    if head > largest do
      findLargestCalories(tail, head)
    else
      findLargestCalories(tail, largest)
    end
  end

  defp findLargestThreeCalories(list) do
    findLargestThreeCalories(list, [0, 0, 0])
  end

  defp findLargestThreeCalories([], largestCaloriesList) do
    largestCaloriesList
  end

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
