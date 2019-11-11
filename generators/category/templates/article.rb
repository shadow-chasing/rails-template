class Article < ApplicationRecord
  before_save :update_published_at
  before_save :update_unpublished_at

  #-----------------------------------------------------------------------------
  # assosiations
  #-----------------------------------------------------------------------------
  belongs_to :category
  belongs_to :category, inverse_of: :articles
  belongs_to :user, counter_cache: true
  #has_many :pictures, as: :imageable
  #accepts_nested_attributes_for :pictures, :allow_destroy => true
  #-----------------------------------------------------------------------------
  # validations
  #-----------------------------------------------------------------------------
  validates_presence_of :title
  #-----------------------------------------------------------------------------
  # scopes
  #-----------------------------------------------------------------------------
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
  scope :most_recent, -> { order(published_at: :desc) }
  #-----------------------------------------------------------------------------
  # callbacks
  #-----------------------------------------------------------------------------
  def update_published_at
    self.published_at = Time.now if published == true
  end

  def update_unpublished_at
    self.published_at = nil if published == false
  end
end
