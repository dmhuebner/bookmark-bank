class Like < ActiveRecord::Base
  belongs_to :bookmark, dependent: :destroy
  belongs_to :user, dependent: :destroy

	validates :bookmark, presence: true
	validates :user, presence: true
end
