class Topic < ActiveRecord::Base
	# Relations
  belongs_to :user
	has_many :bookmarks, dependent: :destroy

	# Validations
	validates :title, length: {minimum: 2, maximum: 200}, presence: true
	validates :user, presence: true

	# Scope
	default_scope {order('title')}

end
