class Numeric
  # Compute a percentage discount from a number
  # 40% off $39 = 39 - (.40 * 39) = $23.40
  def minus_percentage_discount(percentage)
    self.to_f - ((percentage.to_f / 100) * self.to_f)
  end
end