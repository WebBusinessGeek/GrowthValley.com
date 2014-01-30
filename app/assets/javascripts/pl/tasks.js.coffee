jQuery ->
  $('#task_list').on 'change','input[type=checkbox]', (e) ->
    task_id = $(this).val()
    checked = $(this).is(':checked')
    payload = { checked: checked }
    $.post("/tasks/" + task_id + "/complete", payload).done (result) ->
      console.log result