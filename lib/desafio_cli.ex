defmodule DesafioCli do
  @moduledoc """
  Ponto de entrada para a CLI.
  """

  def get_input(data) do
    commands = IO.gets("> ") |> String.upcase() |> String.trim()

    updated_data = manage_commands(commands, data)

    IO.puts("\nUpdated data:")
    IO.inspect(updated_data)

    get_input(updated_data)
  end

  def set(commands, data) do
    [_cmd, key, value] = String.split(commands, " ", parts: 3, trim: true)

    [%{key => value} | data]
  end

  def begin(commands, data) do
    [_cmd | key] = String.split(commands, " ", parts: 2, trim: true)
    IO.puts("key: #{key}")
    IO.puts("key (string): #{to_string(key)}")
    IO.puts("data:")
    IO.inspect(data)

    # lista = [
    #   %{"TESTO" => "4\n"},
    #   %{"TESTA" => "3\n"},
    #   %{"TESTE" => "2\n"},
    #   %{"LEVEL" => "1\n"}
    # ]

    IO.puts("\nResultado do begin:")

    filtered_map =
      Enum.filter(data, fn item -> Map.get(item, to_string(key)) end)
      |> Map.get(to_string(key))

    IO.inspect(filtered_map)
  end

  def manage_commands(commands_array, data) do
    [cmd | _opts] = String.split(commands_array, " ", parts: 3, trim: true)

    case cmd do
      "SET" ->
        set(commands_array, data)

      "BEGIN" ->
        begin(commands_array, data)

      _ ->
        raise RuntimeError, "Oh, no!"
    end
  end

  @doc """
  A função main recebe os argumentos passados na linha de
  comando como lista de strings e executa a CLI.
  """
  def main(_args) do
    data_list = []
    get_input(data_list)
  end
end
