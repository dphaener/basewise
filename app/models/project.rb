class Project < ActiveRecord::Base
  belongs_to :user

  has_many :todo_lists

  validates :title, length: { minimum: 5 }
end
