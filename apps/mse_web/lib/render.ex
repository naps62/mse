defimpl ExAdmin.Render, for: DateTime do
  def to_string(datetime) do
    {:ok, str} = Timex.format(datetime, "{relative}", :relative)
    str
  end
end

defimpl ExAdmin.Render, for: Money do
  def to_string(money) do
    Money.to_string money
  end
end
