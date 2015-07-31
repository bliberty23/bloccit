class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  
  validates :value, inclusion: { in: [-1, 1], 
    message: "%{value} is not a valid vote." }
  #validates :user, uniqueness: { scope: :post,
  #  message: "One vote, per user, per post." }
  
  after_save :update_post

  private

  def update_post
    post.update_rank
  end
end
