class User < ActiveRecord::Base
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :roles

  attr_accessible :email, :password, :password_confirmation

  def admin?
    roles.where(name: "admin").exists?
  end

end
