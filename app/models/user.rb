class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :sessions, foreign_key: "user_id", class_name: 'Token'

  def self.is_valid_user(email, password)
    @user = User.find_by(email: email)
    (@user.present? and @user.valid_password?(password)) ? @user : nil
  end

end
