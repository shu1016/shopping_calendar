class Event < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  validate :start_end_check
  validate :start_check

  def start_end_check
    errors.add(:end_time, "開始日より遅い日を設定してください") if self.start_time > self.end_time
  end

  def start_check
    errors.add(:start_time, "開始日は本日以降の日を入力してください") if self.start_time <= DateTime.now - 1
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "end_time", "id", "start_time", "title", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["favorites", "user"]
  end

end
