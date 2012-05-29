$ = jQuery
$ ->
  $(".toggle-children").on "click", (e) ->
    $(this).next().toggle()
    toggleMinusPlus($(this))
    e.preventDefault()
  rows = $(".molecule_assessments tr")
  for i in [rows.length..0]
    $row = $(rows[i])
    console.log $row
    for cell, i in $row.find("td")
      $cell = $(cell)
      $prev_cell_in_col = $($cell.parent().prev().find("td")[i])
      console.log $cell
      console.log "previous cell in column is "
      console.log $prev_cell_in_col
      $cell.html("") if $prev_cell_in_col.html() is $cell.html()

toggleMinusPlus = (element) ->
  $icon = $(element.find("i"))
  $icon.toggleClass("icon-plus icon-minus")

