class TopicPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

	def my_bookmarks?
		user.present?
	end
end
