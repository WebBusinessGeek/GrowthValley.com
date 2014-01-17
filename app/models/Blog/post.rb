module Blog
  class Post < ActiveRecord::Base
    has_many :taggings
    has_many :tags, through: :taggings, dependent: :destroy

    before_validation :generate_url
    scope :default,  -> {order("published_at DESC, blog_posts.created_at DESC, blog_posts.updated_at DESC") }
    scope :published, -> { default.where(published: true).where("published_at <= ?", DateTime.now) }

    # validates :user_id, presence: true
    validates :title, :content, :url, :published_at, presence: true
    validates :url, uniqueness: true
    validate :url_do_not_start_with_slash

    def tag_list= tags_attr
      self.tag!(tags_attr.split(","))
    end

    def tag_list
      self.tags.map { |tag| tag.name }.join(", ") if self.tags
    end

    def tag!(tags_attr)
      self.tags = tags_attr.map(&:strip).reject(&:blank?).map do |tag|
        Blog::Tag.where(name: tag).first_or_create
      end
    end

    private

    def generate_url
      return unless self.url.blank?
      year = self.published_at.class == ActiveSupport::TimeWithZone ? self.published_at.year : DateTime.now.year
      self.url = "#{year}/#{self.title.parameterize}"
    end

    def url_do_not_start_with_slash
      errors.add(:url, I18n.t("activerecord.errors.models.blog/post.attributes.url.start_with_slash")) if self.url.start_with?("/")
    end
  end
end