$ = jQuery
$ ->
  $(".toggle-children").on "click", (e) ->
    $(this).next().toggle()
    toggleMinusPlus($(this))
    e.preventDefault()

  rows = $(".molecule_assessments tr")
  for i in [rows.length..0]
    $row = $(rows[i])
    selected_columns = [$row.find("td")[0], $row.find("td")[1]]
    console.log selected_columns
    for cell, i in selected_columns
      $cell = $(cell)
      $prev_cell_in_col = $($cell.parent().prev().find("td")[i])
      $cell.html("-") if $prev_cell_in_col.html() is $cell.html()

toggleMinusPlus = (element) ->
  $icon = $(element.find("i"))
  $icon.toggleClass("icon-plus icon-minus")

