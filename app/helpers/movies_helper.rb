module MoviesHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direciton == "asc" ? "desc" : "asc"
    link_to title, :sort => column, :direction => direction
  end
end
