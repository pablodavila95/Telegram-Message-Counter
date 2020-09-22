defmodule ChatAnalyzer do
  @moduledoc """
  Documentation for `ChatAnalyzer`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ChatAnalyzer.hello()
      :world

  """
  def hello do
    :world
  end

  @doc """
  Gets json from file

  ## Example
      iex> ChatAnalyzer.get_json('./result.json')
      %{json}
  """
  def get_json(filename) do
    with {:ok, body} <- File.read(filename), {:ok, json} <- Jason.decode!(body), do: {:ok, json}
  end

  def get_messages(json) do
    Map.get(json, "messages")
  end

  def get_number_of_messages_from_user(messages, user) do
    Enum.group_by(messages, & &1["from"])
    |> Map.delete(nil)
    |> Map.get(user)
    |> Kernel.length()
  end

  def compare_results(messages, user1, user2) do
    user1_data = get_number_of_messages_from_user(messages, user1)
    user2_data = get_number_of_messages_from_user(messages, user2)

    {user1percentage, user2percentage} = calculate_percentage(user1_data, user2_data)

    IO.puts(inspect("The total of messages is #{user1_data + user2_data}"))
    IO.puts(inspect("#{user1} accounted for %#{user1percentage} of the messages"))
    IO.puts(inspect("#{user2} accounted for %#{user2percentage} of the messages"))
  end

  defp calculate_percentage(user1_data, user2_data) do
    percentage1 = (user1_data / (user1_data + user2_data)) * 100
    percentage2 = (user2_data / (user1_data + user2_data)) * 100

    {percentage1, percentage2}
  end
end
