class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :title
      t.boolean :complete, default: false
      t.references :todo_list, index: true

      t.timestamps null: false
    end
    add_foreign_key :todos, :todo_lists
  end
end
