$ ->
  TodoListData = flight.component(
    ->
      @create = (ev, data) ->
        jqxhr = $.ajax
          method: "POST"
          contentType: "application/json; charset=utf-8"
          dataType: "json"
          url: "/projects/#{context.project_id}/todo_lists"
          data: JSON.stringify({ todo_list: data })

        jqxhr.done (data) =>
          if data.success
            @trigger("dataTodoListCreated", data)
          else
            @trigger("dataTodoListCreationFailed", data)

        jqxhr.fail (xhr) =>
          @trigger("dataTodoListCreationFailed")

      @after "initialize", ->
        @on document, "uiTodoListCreationRequested", @create
  )

  TodoListData.attachTo(document)