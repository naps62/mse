defmodule MseLogging.FileLogger do
  if Mix.env == :dev do
    def append(name, line) do
      {:ok, file} = File.open("log/" <> name, [:append, :utf8])

      IO.puts line
      IO.puts file, line

      File.close(file)
    end
  else
    def append(name, line) do
      IO.puts line
    end
  end
end
