$ = jQuery
$ ->
  $(".toggle-children").on "click", (e) ->
    $(this).next().toggle()
    e.preventDefault()

