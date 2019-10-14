defmodule Xip do
  def compare_message_compress() do
    message = SmartCity.TestDataGenerator.create_data(%{})

    Benchwarmer.benchmark(
      [&Xip.base/1, &Xip.zlib/1, &Xip.snappy/1, &Xip.protobuf/1, &Xip.lz4/1],
      message
    )

    [
      byte_size: [
        base: base(message) |> byte_size(),
        snappy: snappy(message) |> elem(1) |> byte_size(),
        zlib: zlib(message) |> byte_size(),
        protobuf: protobuf(message) |> byte_size(),
        lz4: lz4(message) |> byte_size()
      ]
    ]
  end

  def base(message) do
    message |> Jason.encode!()
  end

  def zlib(message) do
    message |> Jason.encode!() |> :zlib.gzip()
  end

  def snappy(message) do
    message |> Jason.encode!() |> :snappyer.compress()
  end

  def protobuf(message) do
    message |> destruct |> encode_payload |> Message.new() |> Protobuf.Encoder.encode()
  end

  def lz4(message) do
    message |> Jason.encode!() |> :lz4.compress() |> elem(1)
  end

  defp destruct(%_{} = message) do
    message
    |> Map.from_struct()
    |> Enum.reduce(%{}, fn {k, v}, acc -> Map.put(acc, k, destruct(v)) end)
  end

  defp destruct(%{} = message) do
    message
    |> Enum.reduce(%{}, fn {k, v}, acc -> Map.put(acc, k, destruct(v)) end)
  end

  defp destruct(message_list) when is_list(message_list) do
    Enum.map(message_list, &destruct/1)
  end

  defp destruct(message_part) do
    message_part
  end

  defp encode_payload(%{payload: payload} = message) do
    Map.put(message, :payload, Jason.encode!(payload))
  end
end
