defmodule UberErrorTest do
  use ExUnit.Case

  test "accepts good arguments" do
    data = %Uber.Error{id: "123", name: "hi mom", transclude: "true"}
    assert [] == Uber.Error.validate(data)
  end

  test "accepts no arguments" do
    data = %Uber.Error{}
    assert [] == Uber.Error.validate(data)
  end

  test "rejects bad string arguments" do
    data = %Uber.Error{name: 123}
    assert (case Uber.Error.validate(data) do
      [{:name, _}] -> true
      _ -> false
    end)
  end

  test "accepts good [string] arguments" do
    data = %Uber.Error{sending: ["application/json", "text/html"]}
    assert [] == Uber.Error.validate(data)
  end

  test "rejects bad [string] arguments" do
    data = %Uber.Error{sending: 123}
    refute [] == Uber.Error.validate(data)
    assert (case Uber.Error.validate(data) do
      [{:sending, _}] -> true
      _ -> false
    end)

    data = %Uber.Error{accepting: "poop"}
    refute [] == Uber.Error.validate(data)
    assert (case Uber.Error.validate(data) do
      [{:accepting, _}] -> true
      _ -> false
    end)

    data = %Uber.Error{rel: ["hi", 123]}
    refute [] == Uber.Error.validate(data)
    assert (case Uber.Error.validate(data) do
      [{:rel, _}] -> true
      _ -> false
    end)
  end

  test "accepts good data: [Uber.Error] argument" do
    data = %Uber.Error{data: [%Uber.Data{}, %Uber.Data{}]}
    assert [] == Uber.Error.validate(data)
  end

  test "rejects bad data: [Uber.Error] argument" do
    data = %Uber.Error{data: ["esad"]}
    refute [] == Uber.Error.validate(data)
    assert (case Uber.Error.validate(data) do
      [{:data, _}] -> true
      _ -> false
    end)
  end
end

