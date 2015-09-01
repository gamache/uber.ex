defmodule UberTest do
  use ExUnit.Case

  test "accepts good arguments" do
    uber = %Uber{profile: "oh yeah"}
    assert [] == Uber.validate(uber)
  end

  test "accepts no arguments" do
    assert [] == Uber.validate(%Uber{})
  end

  test "rejects bad :profile" do
    assert (case Uber.validate(%Uber{profile: 123}) do
      [{:profile, _}] -> true
      _ -> false
    end)
  end

  test "accepts good :data" do
    assert [] == Uber.validate(%Uber{data: [%Uber.Data{}]})
  end

  test "rejects bad :data" do
    assert (case Uber.validate(%Uber{data: "omglol"}) do
      [{:data, _}] -> true
      _ -> false
    end)
  end

  test "accepts good :error" do
    assert [] == Uber.validate(%Uber{error: [%Uber.Error{}]})
  end

  test "rejects bad :error" do
    assert (case Uber.validate(%Uber{error: 22}) do
      [{:error, _}] -> true
      _ -> false
    end)
  end
end
