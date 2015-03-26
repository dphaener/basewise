$ ->
  TodoData = flight.component(
    ->
      @create = (ev, data) ->
        jqxhr = $.ajax
          method: "POST"
          contentType: "application/json; charset=utf-8"
          dataType: "json"
          url: "/projects/#{context.project_id}/todo_lists/#{data.todo_list_id}/todos"
          data: JSON.stringify({ todo: data })

        jqxhr.done (data) =>
          if data.success
            @trigger("dataTodoCreated", data)
          else
            @trigger("dataTodoCreationFailed", data)

        jqxhr.fail (xhr) =>
          @trigger("dataTodoCreationFailed")

      @update = (ev, data) ->
        jqxhr = $.ajax
          method: "PUT"
          contentType: "application/json; charset=utf-8"
          dataType: "json"
          url: "/projects/#{context.project_id}/todo_lists/#{data.todo_list_id}/todos/#{data.todo_id}"
          data: JSON.stringify({ todo: data })

        jqxhr.done (data) =>
          if data.success
            @trigger("dataTodoUpdated", data)
          else
            @trigger("dataTodoUpdateFailed", data)

        jqxhr.fail (xhr) =>
          @trigger("dataTodoUpdateFailed")

      @after "initialize", ->
        @on document, "uiTodoCreationRequested", @create
        @on document, "uiTodoUpdateRequested", @update
  )

  TodoData.attachTo(document)