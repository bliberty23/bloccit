class VotesController < ApplicationController
  before_action :load_post_and_vote
  
  def up_vote
    update_vote!(1)
    redirect_to :back
  end
  
   def down_vote
    update_vote!(-1)
    redirect_to :back
  end
  
  private
  
  def load_post_and_vote
   @post = Post.find(params[:post_id])
   @vote = @post.votes.find_by_user_id current_user.id
  end
  
  def update_vote!(new_value)
    if @vote.present?
      authorize @vote, :update?
      @vote.update_attribute(:value, new_value)
    else
      @vote = Vote.new(user: current_user, post: @post)
      authorize @vote, :create?
      @vote.save
    end
  end
end