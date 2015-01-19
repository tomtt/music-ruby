class Object
  def blank?
    nil || to_s.strip.empty?
  end

  def present?
    !blank?
  end
end
