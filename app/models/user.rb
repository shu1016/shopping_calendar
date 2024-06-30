class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :events
  has_many :favorites, dependent: :destroy
  

  
  validates :nickname, presence: true
  validates :city, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :region

  validates :region_id, numericality: { other_than: 1 , message: "can't be blank"}

  def self.ransackable_attributes(auth_object = nil)
    ["city", "created_at", "email", "encrypted_password", "id", "nickname", "region_id", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end
  
end
