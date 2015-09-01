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
    assert (case Uber.Data.validate(data) do
      [{:name, _}] -> true
      _ -> false
    end)
  end

  test "accepts good [string] arguments" do
    data = %Uber.Data{sending: ["application/json", "text/html"]}
    assert [] == Uber.Data.validate(data)
  end

  test "rejects bad [string] arguments" do
    data = %Uber.Data{sending: 123}
    refute [] == Uber.Data.validate(data)
    assert (case Uber.Data.validate(data) do
      [{:sending, _}] -> true
      _ -> false
    end)

    data = %Uber.Data{accepting: "poop"}
    refute [] == Uber.Data.validate(data)
    assert (case Uber.Data.validate(data) do
      [{:accepting, _}] -> true
      _ -> false
    end)

    data = %Uber.Data{rel: ["hi", 123]}
    refute [] == Uber.Data.validate(data)
    assert (case Uber.Data.validate(data) do
      [{:rel, _}] -> true
      _ -> false
    end)
  end

  test "accepts good data: [Uber.Data] argument" do
    data = %Uber.Data{data: [%Uber.Data{}, %Uber.Data{}]}
    assert [] == Uber.Data.validate(data)
  end

  test "rejects bad data: [Uber.Data] argument" do
    data = %Uber.Data{data: ["esad"]}
    refute [] == Uber.Data.validate(data)
    assert (case Uber.Data.validate(data) do
      [{:data, _}] -> true
      _ -> false
    end)
  end
end

