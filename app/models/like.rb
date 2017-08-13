class Like < ActiveRecord::Base
  belongs_to :bookmark
  belongs_to :user

	validates :bookmark, presence: true
	validates :user, presence: true
end
