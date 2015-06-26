 class PostPolicy < ApplicationPolicy
   class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(:published => true)
      end
    end
   end

  def update?
    user.admin? or not post.published?
  end
  
  def destroy?
    user.present? && (record.user == user || user.admin? || user.moderator?)
  end
  
 end