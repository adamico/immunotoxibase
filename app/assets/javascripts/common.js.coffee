jQuery ->

  ### Charles Lawrence - Feb 16, 2012. Free to use and modify. Please attribute back to @geuis if you find this useful
 Twitter Bootstrap Typeahead doesn't support remote data querying. This is an expected feature in the future. In the meantime, others have submitted patches to the core bootstrap component that allow it.
 The following will allow remote autocompletes *without* modifying any officially released core code.
 If others find ways to improve this, please share.###

  $('#molecule').typeahead()
  .on 'keyup', (ev) ->
      self = $(this)
      ev.stopPropagation()
      ev.preventDefault()

      #ensure up/down, tab, enter, and escape keys are filtered out and entered text is at least 2 chars
      if $.inArray(ev.keyCode, [40,38,9,13,27]) and self.val().length > 1
        #set typeahead source to empty
        self.data('typeahead').source = []

        #active used so we aren't triggering duplicate keyup events
        if !self.data('active') and self.val().length > 0
          self.data('active', true)

          #Do data request. Insert your own API logic here.
          $.getJSON "/home/autocomplete_section_name.json",
            term: $(this).val(),
            (data) ->
              #set this to true when your callback executes
              self.data('active',true)
              console.log data

              #Filter out your own parameters. Populate them into an array, since this is what typeahead's source requires
              results = []
              results.push item.value for item in data

              #set your results into the typehead's source
              self.data('typeahead').source = results

              #trigger keyup on the typeahead to make it search
              self.trigger('keyup')

              #All done, set to false to prepare for the next remote query.
              self.data('active', false)

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

