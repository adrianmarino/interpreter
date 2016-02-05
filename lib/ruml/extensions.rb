class String
  def strip_heredoc
    indent = scan(/^[ \t]*(?=\S)/)
    indent = indent.min ? indent.min.size : 0
    gsub(/^[ \t]{#{indent}}/, '')
  end

  def singular?
    singularize == self
  end
end
