 class CommentPolicy < ApplicationPolicy
  
  def create?
    show?
  end

  def destroy?
    super
  end

  def show?
    user.present?
  end

  class Scope < Scope
    def resolve
      if user.preset? and user.admin?
        scope.all
      else
        scope.where(published: true)
      end
    end
  end
end