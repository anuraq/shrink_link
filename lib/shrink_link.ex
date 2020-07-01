defmodule ShrinkLink do
  @moduledoc """
  Documentation for `ShrinkLink`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ShrinkLink.hello()
      :world

  """
  def hello do
    :world
  end

  def start(_t, _a) do
    hello()
  end
end
