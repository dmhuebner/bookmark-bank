class Bookmark < ActiveRecord::Base
	# FriendlyId
	extend FriendlyId
	friendly_id :name, use: :slugged

	# Relations
  belongs_to :topic
	belongs_to :user
	has_many :likes, dependent: :destroy

	# Validations
	validates :url, length: {minimum: 3}, presence: true
	validates :description, length: {maximum: 100}
	validates :name, length: {minimum: 1}, presence: true
	validates :topic, presence: true
	validates :user, presence: true

	# Scope
	default_scope {order('name')}
end
