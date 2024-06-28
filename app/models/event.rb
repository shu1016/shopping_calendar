class Event < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  validate :start_end_check

  def start_end_check
    errors.add(:end_time, "は開始時間より遅い時間を設定してください") if self.start_time > self.end_time
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
