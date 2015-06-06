class Post < ActiveRecord::Base
    has_many :comments
    belongs_to :user
    
    #default_scope { order('created_at DESC') }
    scope :published, -> { where(published: true) }
    scope :ordered_by_title, -> { order(:title) }
    scope :ordered_by_reverse_created_at, -> { order(:name).reverse_order }
end
