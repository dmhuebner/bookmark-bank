class Bookmark < ActiveRecord::Base
	# Relations
  belongs_to :topic

	# Validations
	validates :url, length: {minimum: 3}, presence: true
	validates :description, length: {maximum: 100}
	validates :name, length: {minimum: 1}, presence: true
	validates :topic, presence: true

	# Scope
	default_scope {order('name')}
end
