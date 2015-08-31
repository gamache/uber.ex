defmodule UberDataTest do
  use ExUnit.Case

  test "accepts good arguments" do
    data = %Uber.Data{id: "123", name: "hi mom", transclude: "true"}
    assert [] == Uber.Data.validate(data)
  end

  test "accepts no arguments" do
    data = %Uber.Data{}
    assert [] == Uber.Data.validate(data)
  end

  test "rejects bad string arguments" do
    data = %Uber.Data{name: 123}
    assert :yes == (case Uber.Data.validate(data) do
      [{:name, _}] -> :yes
      _ -> :no
    end)
  end
  test "accepts good [string] arguments" do
    data = %Uber.Data{sending: ["application/json", "text/html"]}
    assert [] == Uber.Data.validate(data)
  end

  test "rejects bad [string] arguments" do
    data = %Uber.Data{sending: 123}
    refute [] == Uber.Data.validate(data)
    assert :yes == (case Uber.Data.validate(data) do
      [{:sending, _}] -> :yes
      _ -> :no
    end)

    data = %Uber.Data{accepting: "poop"}
    refute [] == Uber.Data.validate(data)
    assert :yes == (case Uber.Data.validate(data) do
      [{:accepting, _}] -> :yes
      _ -> :no
    end)

    data = %Uber.Data{sending: ["hi", 123]}
    refute [] == Uber.Data.validate(data)
    assert :yes == (case Uber.Data.validate(data) do
      [{:sending, _}] -> :yes
      _ -> :no
    end)

  end
end

