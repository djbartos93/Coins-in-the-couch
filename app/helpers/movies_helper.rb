module MoviesHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direciton}" : nil
    direction = column == sort_column && sort_direciton == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class =>css_class}
  end
end
