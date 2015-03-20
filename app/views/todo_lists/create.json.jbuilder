if @todo_list.errors.any?
  json.success false

  json.errors do
    @todo_list.errors.full_messages.each_with_index do |error, index|
      json.set!(index, error)
    end
  end

else
  json.success true
  json.todo_list_html render("todo_lists/list", project: @project, format: :html)
end