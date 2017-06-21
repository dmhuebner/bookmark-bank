class Topic < ActiveRecord::Base
	# Relations
  belongs_to :user
	has_many :bookmarks

	# Validations
	validates :title, length: {minimum: 1, maximum: 200}, presence: true
	validates :user, presence: true
end
