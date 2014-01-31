jQuery ->
  $('#active_classrooms').sortable
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))

  $('#classrooms').disableSelection()