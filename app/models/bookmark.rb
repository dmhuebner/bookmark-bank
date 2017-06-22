class Bookmark < ActiveRecord::Base
	# Relations
  belongs_to :topic

	# Validations
	validates :url, length: {minimum: 3}, presence: true
	validates :topic, presence: true
end
