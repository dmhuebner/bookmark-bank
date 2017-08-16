class Topic < ActiveRecord::Base
	# FriendlyId
	extend FriendlyId
	friendly_id :title, use: :slugged

	# Relations
  belongs_to :user
	has_many :bookmarks, dependent: :destroy

	# Validations
	validates :title, length: {minimum: 2, maximum: 200}, presence: true
	validates :user, presence: true

	# Scope
	default_scope {order('title')}

end
