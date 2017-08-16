class User < ActiveRecord::Base
	# FriendlyId
	extend FriendlyId
	friendly_id :name, use: :slugged
	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

	# Relations
	has_many :topics
	has_many :bookmarks
	has_many :likes, dependent: :destroy

	# Validations
	validates :name, length: {minimum: 1, maximum: 100}, presence: true

	def liked(bookmark)
		likes.where(bookmark_id: bookmark.id).first
	end
end
