class TodoList < ActiveRecord::Base
  belongs_to :project

  has_many :todos, dependent: :destroy

  delegate :title, to: :project, prefix: true

  default_scope { order(created_at: :desc) }

  validates :title, presence: true
end
