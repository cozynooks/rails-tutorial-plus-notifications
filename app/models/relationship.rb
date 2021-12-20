class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  has_many :notifications, as: :subject, dependent: :destroy

  validates :follower_id, presence: true
  validates :followed_id, presence: true

  after_create_commit :create_notifications

  private

  def create_notifications
    Notification.create!(subject: self, user: follower)
  end

end