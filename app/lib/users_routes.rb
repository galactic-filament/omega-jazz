require 'json'
require 'active_record'
require 'bcrypt'
require File.expand_path '../base', __FILE__

class User < ActiveRecord::Base
  include BCrypt

  validates :email, presence: true
  validates :hashed_password, presence: true

  def password
    @password ||= Password.new(self.hashed_password)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.hashed_password = @password
  end
end

class UsersRoutes < Base
  set :show_exceptions, false
  error do
    {message: env['sinatra.error'].message}.to_json
  end

  post '/users' do
    content_type :json
    status 400

    parsed_body = JSON.parse(request.body.read)
    user = User.new({
      email: parsed_body['email']
    })
    user.password = parsed_body['password']
    return if user.valid? == false

    status 201
    user.save!
    user.to_json only: [:id, :email]
  end
end
