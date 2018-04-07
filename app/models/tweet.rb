class Tweet < ApplicationRecord
  belongs_to :user

  validates :user_id, :body, presence: true
  validates :body, length: { maximum: 280 }
  before_create :post_to_twitter
  mount_uploader :image, ImageUploader

  def post_to_twitter
    if check_user_twitter
      if image.blank?
        @obj_twit = user.twitter.update(body)
      else
        uri = open("http://localhost:3000#{image}")
        raise 'Error loading image' unless uri
        @obj_twit = user.twitter.update_with_media(body, uri)
      end
      self.twitter_url = @obj_twit.id
    end
  end

  private

  def check_user_twitter
    ob = User.find(self.user_id)
    ob.provider
  end
end
