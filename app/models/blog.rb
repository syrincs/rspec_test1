class Blog < ApplicationRecord
  validates_presence_of :name, on: :create, message: "can't be blank"
end
