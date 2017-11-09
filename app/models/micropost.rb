class Micropost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 50}
  validates :content, presence: true

  scope :sort_by_created_at, ->{order created_at: :desc}
  def self.search(search)
    where("title LIKE ?", "%#{search}%")
  end
end
