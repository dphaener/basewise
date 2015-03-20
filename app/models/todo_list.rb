class TodoList < ActiveRecord::Base
  belongs_to :project

  has_many :todos, dependent: :destroy

  validates :title, presence: true
end
