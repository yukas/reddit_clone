class Post < ApplicationRecord
  belongs_to :user

  has_many :votes
  has_many :comments

  validates :title, :text, presence: true

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  
  def vote_up(vote_params)
    @vote_up = votes.create(vote_params.merge(vote_type: 'up'))
    
    votes.where(user_id: vote_params[:user_id], vote_type: ['down']).destroy
  end
  
  def vote_down
    ...
  end
  
  def from_vote_up?(user)
    votes.where({user_id: user.id, vote_type: 'up'}).present?
  end

  def from_vote_down?(user)
    votes.where({user_id: user.id, vote_type: 'down'}).present?
  end
end
