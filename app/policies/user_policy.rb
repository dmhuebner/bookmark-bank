class UserPolicy < ApplicationPolicy

	def show?
    @user.present? && @record.exists?
  end

end
