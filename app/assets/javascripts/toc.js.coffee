$ = jQuery
$ ->
  dontRepeatCells()
  $(".toggle-children").on "click", (e) ->
    e.preventDefault()
    $(this).next().toggle()
    toggleMinusPlus($(this))

  assignReorderAssessments $("#reorder_assessments")

assignDoneReordering = (element) ->
  element.one "click", (e) ->
    e.preventDefault()
    $("#reorder_assessments").toggle()#Class("disabled")
    dontRepeatCells()
    $(this).toggle()#Class("disabled")
    $("#assessments tr").unbind()
    assignReorderAssessments $("#reorder_assessments")

assignReorderAssessments = (element) ->
  element.one "click", (e) ->
    e.preventDefault()
    recoverCellContent $("#assessments")
    $(this).toggle()#Class("disabled")
    setupDnDTable()
    $("#done_reordering").toggle()#Class("disabled")
    assignDoneReordering $("#done_reordering")

dontRepeatCells = ->
  rows = $("#assessments tr")
  for i in [rows.length..1]
    $row = $(rows[i])
    selected_columns = [$row.find("td")[3], $row.find("td")[2], $row.find("td")[1], $row.find("td")[0]]
    for cell, i in selected_columns
      col = selected_columns.length - i - 1
      $cell = $(cell)
      $prev_cell_in_col = $($cell.parent().prev().find("td")[col])
      $prev_cell_in_row = $($cell).prev()
      $prev_cell_in_prev_row = $($prev_cell_in_row.parent().prev().find("td")[col-1])
      $cell.html("-") if $prev_cell_in_col.html() is $cell.html() and $prev_cell_in_row.html() is $prev_cell_in_prev_row.html() unless col is 0

toggleMinusPlus = (element) ->
  $icon = $(element.find("i"))
  $icon.toggleClass("icon-plus icon-minus")

recoverCellContent = (table) ->
  for row in $(table).find("tr")
    for cell in $(row).find("td")
      value = $(cell).data("value")
      $(cell).html(value)

setupDnDTable = ->
  $("#assessments").tableDnD
    onDrop: (table, row) ->
      $.post("/admin/sections/sort", $.tableDnD.serialize())
    dragHandle: ".dragHandle"
    serializeRegexp: /[^\_]*$/

  $("#assessments tr").hover(
    -> $(this.cells[0]).addClass('showDragHandle'),
    -> $(this.cells[0]).removeClass('showDragHandle'))
