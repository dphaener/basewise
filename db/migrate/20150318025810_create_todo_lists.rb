class CreateTodoLists < ActiveRecord::Migration
  def change
    create_table :todo_lists do |t|
      t.string :title
      t.string :description
      t.references :project, index: true

      t.timestamps null: false
    end
    add_foreign_key :todo_lists, :projects
  end
end
