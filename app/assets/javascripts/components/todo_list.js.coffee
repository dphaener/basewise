$ ->
  TodoListUI = flight.component(
    ->
      @defaultAttrs
        newTodoSelector: "[data-action='new-todo']"
        newTodoListSelector: "[data-action='new-todo-list']"
        createTodoSelector: "[data-action='create-todo']"
        createTodoListSelector: "[data-action='create-todo-list']"
        cancelSelector: "[data-action='cancel']"
        titleSelector: "[data-attribute='title']"
        descriptionSelector: "[data-attribute='description']"
        todoContainer: "[data-container='new-todo-list']"
        todoListContainer: "[data-container='todo-lists']"
        newTodoContainer: "[data-container='new-todo']"
        itemSelector: "[data-item]"

      #######################
      # Todo List Section   #
      #######################

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

      #######################
      # Todo Section        #
      #######################

      @showNewTodo = (ev, data) ->
        $el = $(data.el)
        $parent = $el.parents("li")
        $parent.find(@attr.newTodoContainer).toggle()

      @after "initialize", ->

        @on "click",
          newTodoListSelector: @showNewTodoList
          cancelSelector: @hideNewTodoList
          createTodoListSelector: @handleCreateTodoList
          newTodoSelector: @showNewTodo


        @on document, "dataTodoListCreated", @handleTodoListCreated
  )

  TodoListUI.attachTo("[data-component='todo-list']")
