defmodule Topshelf.Measurements do
  @units ["oz", "ml"]

  def validate_measurement(changeset, field) do
    Ecto.Changeset.validate_change(changeset, field, fn field, value ->
      case to_measure(value) do
        {_measure, unit} when unit in @units ->
          []

        {_value, unit} ->
          [
            {field,
             "'#{field}' must be have a valid unit of measuremnt (#{@units}). '#{unit}' is not a valid unit. Eg. '750ml'"}
          ]

        :error ->
          [{field, "'#{field}' must be an integer followed by a unit (#{@units}). Eg. '750ml'"}]
      end
    end)
  end

  def to_measure(volume) when is_binary(volume), do: Float.parse(volume)
  def to_measure(nil), do: :infintite

  def percent_of_measure({amount, unit}, percent), do: {amount * percent, unit}
  def percent_of_measure(:infintite, _percent), do: :infintite

  def measure_to_percent({remaining, unit}, {total, unit}), do: remaining / total
  def measure_to_percent(:infintite, :infintite), do: 1.0

  def pour(container, pour) when is_binary(container) and is_binary(pour) do
    pour(to_measure(container), to_measure(pour))
  end

  def pour({container_amount, container_unit}, {pour_amount, pour_unit})
      when container_unit != pour_unit do
    pour({container_amount, container_unit}, convert({pour_amount, pour_unit}, container_unit))
  end

  def pour({container_amount, unit}, {pour_amount, unit}) do
    case container_amount - pour_amount do
      amount when amount > 0.0 -> {amount, unit}
      _ -> {0.0, unit}
    end
  end

  def pour(:infintite, {_pour_amount, _unit}), do: :infintite

  def convert({amount, unit}, destination_unit)
      when unit in @units and destination_unit in @units do
    amount =
      case {unit, destination_unit} do
        {u, u} -> amount * 1.0
        {"oz", "ml"} -> amount * 29.574
        {"ml", "oz"} -> amount / 29.574
      end

    {Float.round(amount, 3), destination_unit}
  end
end
