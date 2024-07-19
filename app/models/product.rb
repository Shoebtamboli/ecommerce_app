class Product < ApplicationRecord
  has_one_attached :thumbnail
  has_many_attached :images
  has_many :cart_items, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  
  validate :thumbnail_presence
  validate :acceptable_thumbnail

  private

  def thumbnail_presence
    errors.add(:thumbnail, "must be attached") unless thumbnail.attached?
  end

  def acceptable_thumbnail
    return unless thumbnail.attached?

    if thumbnail.blob.byte_size > 1.megabyte
      errors.add(:thumbnail, "is too big")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(thumbnail.content_type)
      errors.add(:thumbnail, "must be a JPEG or PNG")
    end
  end
end