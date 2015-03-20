$ ->
  TodoListUI = flight.component(
    ->
      @defaultAttrs
        newTodoSelector: "[data-action='new-todo']"
        createTodoSelector: "[data-action='create-todo']"
        cancelSelector: "[data-action='cancel']"
        titleSelector: "[data-attribute='title']"
        descriptionSelector: "[data-attribute='description']"
        todoContainer: "[data-container='new-todo']"
        todoListContainer: "[data-container='todo-lists']"

      @serializeForm = ->
        title: @select("titleSelector").val()
        description: @select("descriptionSelector").val()

      @clearForm = ->
        @select("titleSelector").val(null)
        @select("descriptionSelector").val(null)

      @showNewTodo = (ev, data) ->
        @select("todoContainer").toggle()

      @hideNewTodo = (ev, data) ->
        @select("todoContainer").hide()

      @handleCreateTodo = (ev, data) ->
        @trigger("uiTodoListCreationRequested", @serializeForm())

      @handleTodoCreated = (ev, data) ->
        @clearForm()
        @hideNewTodo()
        @select("todoListContainer").html(data.todo_list_html)

      @after "initialize", ->

        @on "click",
          newTodoSelector: @showNewTodo
          cancelSelector: @hideNewTodo
          createTodoSelector: @handleCreateTodo

        @on document, "dataTodoListCreated", @handleTodoCreated
  )

  TodoListUI.attachTo("[data-component='todo-list']")
