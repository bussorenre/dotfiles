if ENV["INSIDE_EMACS"]
  Pry.config.color = false
  Pry.config.pager = false
  Pry.config.correct_indent = false
end