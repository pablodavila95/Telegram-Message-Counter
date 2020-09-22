defmodule ChatAnalyzerTest do
  use ExUnit.Case
  doctest ChatAnalyzer

  test "greets the world" do
    assert ChatAnalyzer.hello() == :world
  end
end
