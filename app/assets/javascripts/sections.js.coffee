$ = jQuery

$ ->
  # setup assignment scripts on load for molecules with existing assignments
  setupAssignment()

  # setup assignment scripts when adding a new assessment
  $attach = $("#assessments")
  $attach.bind 'insertion-callback', ->
    activateRemoteForm()
    $(".update").hide()
    $reference_autocomplete = $(".reference_id_field")
    assignDataIdElement($reference_autocomplete)
    $reference_autocomplete.bind "railsAutocomplete.select", (e, data) ->
      activateReferenceEdit($reference_autocomplete)

activateReferenceEdit = (elements) ->
  for element in elements
    autocomplete = $(element).find("input[type=text]")
    $reference_id_input = $(autocomplete).parent().find("input[type=hidden]")
    reference_id = $reference_id_input.val()
    if reference_id
      $edit_reference_btn = $(element).find(".update")
      $edit_reference_btn.show()
      $edit_reference_btn.attr("data-link", "/admin/references/#{reference_id}/edit")
      $("#reference_modal_title").html("Edit reference #{reference_id}")
      $("#save-reference").html("Edit reference and assign to molecule")

assignDataIdElement = (elements) ->
  if elements.length
    for element in elements
      targetId = $(element).parent().find("input[type=hidden]").attr("id")
      $autocomplete = $(element).find("input[type=text]")
      $autocomplete.attr("data-id-element", "##{targetId}")

activateRemoteForm = ->
  if $("#modal").length
    $(".reference_id_field .btn").hide()
  else
    for element in $(".reference_id_field")
      $(element).remoteForm()

setupAssignment = ->
  # activate RemoteForm on load for molecule with existing assignments
  activateRemoteForm()

  $reference_autocomplete = $(".reference_id_field")
  assignDataIdElement($reference_autocomplete)
  activateReferenceEdit($reference_autocomplete)

  # activate edit reference when reference autocomplete item is selected
  $reference_autocomplete.bind "railsAutocomplete.select", (e, data) ->
    reference_id = data.item.id
    activateReferenceEdit($reference_autocomplete)
