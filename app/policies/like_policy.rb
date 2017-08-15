class LikePolicy < ApplicationPolicy
	def index?
		user.present?
	end
end
