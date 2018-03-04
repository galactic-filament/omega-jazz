require 'active_record'

class Post < ActiveRecord::Base
  validates :body, presence: true
end
