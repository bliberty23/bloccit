 class PostPolicy < ApplicationPolicy
   class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.present?
        scope.where(user_id: user.id)
      else
        scope.where(:published => true)
      end
    end
   end

  def update?
    user.admin? or not post.published?
  end
 end