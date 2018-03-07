defimpl ExAdmin.Render, for: Money do
  def to_string(money) do
    Money.to_string(money)
  end
end
