require "notepasser/version"
require "notepasser/init_db"
require "camping"
require "pry"
require 'json'

Camping.goes :Notepasser

module Notepasser
end

module Notepasser::Models

  class User<ActiveRecord::Base
    validates :name, presence :true, uniqueness :true, format: {with: /\A[a-z\d]*\Z/i,
      message: "no symbols, punk." }
    validates :password presence :true #TODO update db with pw col...
    has_many :messages
  end

  class Message<ActiveRecord::Base
    validates :content, presence :true, uniqueness :true
    validates :recipient_id, presence :true
    belongs_to :user
  end
end

module Notepasser::Controllers

# ip address : http://...
  class UserController < R '/users/new'
  #Users: Support adding user accounts.
  @User = Notepasser::Models::User

    def post_user
      new_user = @User.create(name: @input).to_json
    end

  class UserController < R '/users//\A[a-z\d]*\Z/i'
#Users: Support retrieving and deleting user accounts.
    @User = Notepasser::Models::User

    def get(username)
      @get_user = @User.find_by(name: username).to_json
    end

    def delete
      @get_user.destroy
    end

  class MessageController < R '/users/msg/add'
#TODO COME BACK...
#integer :recipient_id, text :content, boolean :read_status
    def post_add_msg(username)
      content = [:recipient_id, :content, :read_status]
      content.each do |c|
        @User.messages.new[c] = @input[c]
      end
      @User.messages.new.save
    end
  end

  class MessageController < R "/users/msg/#{username}"
    @UserMessage = Notepasser::Models::User.messages
    #:firstname => "john"
    def get_all_msg(opt={})
      if opt = {}
        Notepasser::Models.messages.all.to_json
      else
        Notepasser::Models.messages.find_by(opt).to_json
      end
    end

    def get_user_msg(username)
      @UserMessage.find_by(username).to_json
    end

    def post_status(username,msg)
      @UserMessage.find_by(name: username).order(read_status: :desc)
      @UserMessage.update(read_status: @input)
      @UserMessage.save
    end

    def delete
      @UserMessage.destroy
    end
  end

end
