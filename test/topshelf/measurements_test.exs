defmodule Topshelf.MeasurementsTest do
  use Topshelf.DataCase

  alias Topshelf.Measurements

  describe "conversion" do
    test "convert/2 is identity when units are the same" do
      assert {1.0, "oz"} = Measurements.convert({1, "oz"}, "oz")
      assert {1.446, "ml"} = Measurements.convert({1.4455, "ml"}, "ml")
    end

    test "convert/2 converts to different units" do
      assert {25.360, "oz"} = Measurements.convert({750, "ml"}, "oz")
      assert {946.368, "ml"} = Measurements.convert({32, "oz"}, "ml")
    end
  end

  describe "pour" do
    test "pour/2 pours into oz from ml" do
      assert {720.426, "ml"} = Measurements.pour({750, "ml"}, {1, "oz"})
      assert {602.130, "ml"} = Measurements.pour({750, "ml"}, {5, "oz"})
      assert {0.0, "ml"} = Measurements.pour({20, "ml"}, {1, "oz"})
    end
  end
end
