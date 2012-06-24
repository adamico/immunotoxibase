jQuery ->

  # fix sub nav on scroll
  $win = $(window)
  $win.on 'scroll', dynamic_subnav

dynamic_subnav = ->
  # If has not activated (has no attribute "data-top")
  if !$('.subnav').attr('data-top')
    # If already fixed, then do nothing
    return if $('.subnav').hasClass('subnav-fixed')
    # Remember top position
    offset = $('.subnav').offset()
    $('.subnav').attr('data-top', offset.top)

  if $('.subnav').attr('data-top') - $('.subnav').outerHeight() <= $(this).scrollTop()
    $('.subnav').addClass('subnav-fixed')
  else
    $('.subnav').removeClass('subnav-fixed')

