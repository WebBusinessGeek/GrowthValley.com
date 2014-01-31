jQuery ->
  $('#lessons').sortable
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))

  $('#lessons').disableSelection()