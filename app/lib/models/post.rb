require 'active_record'

class Post < ActiveRecord::Base
  has_many :comments

  validates :body, presence: true
end
