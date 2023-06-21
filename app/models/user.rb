# frozen_string_literal: true

# User Model Class
class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Discard::Model
  include Validations::User
  include Helpers::User

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable
  # :omniauthable, :registerable, and :recoverable
  devise :database_authenticatable, :rememberable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ''
  field :encrypted_password, type: String, default: ''

  ## Recoverable
  # field :reset_password_token,   type: String
  # field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  # User's Fields
  field :fullname, type: String
  field :username, type: String, default: -> { email }
  field :role, type: String
  field :discarded_at, type: DateTime

  index({ fullname: 'text', username: 'text' })
end
