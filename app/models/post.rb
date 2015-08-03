class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  belongs_to :user
  belongs_to :topic

  mount_uploader :image, ImageUploader
  
  default_scope { order('rank DESC') }
  
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true

  after_create :create_vote

  def up_votes
    votes.where(value: 1).count
  end
  
  def down_votes
    votes.where(value: -1).count
  end
  
  def points
    votes.sum(:value)
  end

  def markdown_title
    render_as_markdown(self.title)
  end
  
  def markdown_body
    render_as_markdown(self.body)
  end

  def save_with_initial_vote
    ActiveRecord::Base.transaction do
      self.save
      create_vote
    end
  end

  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / (60 * 60 * 24) # 1 day in seconds
    new_rank = points + age_in_days

    update_attribute(:rank, new_rank)
  end

  private
 
  def render_as_markdown(markdown)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render markdown).html_safe
  end
  
  def create_vote
    unless votes.find_by_user_id self.user_id
      Vote.create(value: 1, post: self, user: self.user)
    else
      return true
    end
  end

end
