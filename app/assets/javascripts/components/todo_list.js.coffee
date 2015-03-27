$ ->
  withTodos = ->
    @defaultAttrs
      newTodoSelector: "[data-action='new-todo']"
      createTodoSelector: "[data-action='create-todo']"
      newTodoContainer: "[data-container='new-todo']"
      todoTitleSelector: "[data-attribute='todo-title']"
      allTodoContainer: "[data-container='all-todos']"
      checkBoxSelector: "input[type='checkbox']"
      cancelCreateTodoSelector: "[data-action='cancel-create-todo']"
      itemSelector: "[data-item]"

    @serializeTodo = ($el) ->
      title: $el.siblings(@attr.todoTitleSelector).val()
      todo_list_id: $el.parents("li").data("todoListId")

    @serializeTodoUpdate = ($el) ->
      todo_list_id: $el.parents("[data-item]").data("todoListId")
      complete: $el.prop("checked")
      todo_id: $el.parents("li").data("todoId")

    @showNewTodo = (ev, data) ->
      $el = $(data.el)
      $parent = $el.parents("li")
      $parent.find(@attr.newTodoContainer).toggle()

    @handleCreateTodo = (ev, data) ->
      @trigger("uiTodoCreationRequested", @serializeTodo($(data.el)))

    @clearTodoForm = ($context) ->
      $context.find(@attr.todoTitleSelector).val(null)

    @updateList = ($context, data) ->
      $context.find(@attr.allTodoContainer).html(data.todo_list_html)
      $container = $context.find(@attr.newTodoContainer)
      $container.hide()

    @handleTodos = (ev, data) ->
      $container = @$node.find("[data-todo-list-id='#{data.todo_list_id}']")
      @updateList($container, data)
      @clearTodoForm($container)

    @handleCheckboxChange = (ev, data) ->
      @trigger("uiTodoUpdateRequested", @serializeTodoUpdate($(data.el)))

    @cancelCreateTodo = (ev, data) ->
      $(data.el).parents(@attr.newTodoContainer).hide()

  TodoListUI = flight.component(
    withTodos,
    ->
      @defaultAttrs
        newTodoListSelector: "[data-action='new-todo-list']"
        createTodoListSelector: "[data-action='create-todo-list']"
        cancelSelector: "[data-action='cancel']"
        titleSelector: "[data-attribute='title']"
        descriptionSelector: "[data-attribute='description']"
        todoContainer: "[data-container='new-todo-list']"
        todoListContainer: "[data-container='todo-lists']"

      @serializeForm = ->
        title: @select("titleSelector").val()
        description: @select("descriptionSelector").val()

      @clearForm = ->
        @select("titleSelector").val(null)
        @select("descriptionSelector").val(null)

      @showNewTodoList = (ev, data) ->
        @select("todoContainer").toggle()

      @hideNewTodoList = (ev, data) ->
        @select("todoContainer").hide()

      @handleCreateTodoList = (ev, data) ->
        @trigger("uiTodoListCreationRequested", @serializeForm())

      @handleTodoListCreated = (ev, data) ->
        @clearForm()
        @hideNewTodoList()
        @select("todoListContainer").html(data.todo_list_html)

      @after "initialize", ->

        @on "click",
          newTodoListSelector: @showNewTodoList
          cancelSelector: @hideNewTodoList
          createTodoListSelector: @handleCreateTodoList
          newTodoSelector: @showNewTodo
          createTodoSelector: @handleCreateTodo
          cancelCreateTodoSelector: @cancelCreateTodo

        @on "change",
          checkBoxSelector: @handleCheckboxChange

        @on document, "dataTodoListCreated", @handleTodoListCreated
        @on document, "dataTodoCreated", @handleTodos
  )

  TodoListUI.attachTo("[data-component='todo-list']")
