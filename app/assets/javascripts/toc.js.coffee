$ = jQuery
$ ->
  $("#assessments").tableDnD
    onDrop: (table, row) ->
      $.post("/admin/sections/sort", $.tableDnD.serialize())
    dragHandle: ".dragHandle"
    serializeRegexp: /[^\_]*$/

  $("#assessments tr").hover(
    -> $(this.cells[0]).addClass('showDragHandle'),
    -> $(this.cells[0]).removeClass('showDragHandle'))

  $(".toggle-children").on "click", (e) ->
    $(this).next().toggle()
    toggleMinusPlus($(this))
    e.preventDefault()

  rows = $("#assessments tr")
  for i in [rows.length..0]
    $row = $(rows[i])
    selected_columns = [$row.find("td")[1], $row.find("td")[2], $row.find("td")[3]]
    for cell, i in selected_columns
      $cell = $(cell)
      $prev_cell_in_col = $($cell.parent().prev().find("td")[i])
      $prev_cell_in_row = $($cell).prev()
      $prev_cell_in_prev_row = $($prev_cell_in_row.parent().prev().find("td")[i-1])
      if i is 2
        $cell.html("-") if $prev_cell_in_col.html() is $cell.html() and $prev_cell_in_row.html() is $prev_cell_in_prev_row.html() or $prev_cell_in_row.html() is "-"
      else
        $cell.html("-") if $prev_cell_in_col.html() is $cell.html()

toggleMinusPlus = (element) ->
  $icon = $(element.find("i"))
  $icon.toggleClass("icon-plus icon-minus")

