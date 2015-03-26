if @todo.errors.any?
  json.success false

  json.errors do
    @todo.errors.full_messages.each_with_index do |error, index|
      json.set!(index, error)
    end
  end

else
  json.success true
  json.todo_list_id @todo_list.id
  json.todo_list_html render("todos/list", todos: @todo_list.todos, format: :html)
end