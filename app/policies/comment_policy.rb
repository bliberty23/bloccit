 class CommentPolicy < ApplicationPolicy

  def update?
    user.present? and (user.admin? or not post.published?)
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