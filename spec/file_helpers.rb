module FileHelpers
  def normalized(file)
    contents = IO.read(file)

    normalize_string_indent contents
  end
end
