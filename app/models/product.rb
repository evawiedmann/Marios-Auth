class Product < ApplicationRecord
  has_many :reviews, dependent: :destroy
  validates :name, presence: true
  validates :cost, presence: true
  validates :country_of_origin, presence: true

  scope :newest_reviews, -> { order(created_at: :desc).limit(3)}
  scope :pop_reviewed, -> {(
    select("products.id, products.name, count(reviews.id) as reviews_count")
    .joins(:reviews)
    .group("products.id")
    .order("reviews_count DESC")
    .limit(1)
    )}

    scope :country_of_origin, -> (country_of_origin_parameter) { where(country_of_origin: "USSR") }
    scope :usa_made_product, -> { where(country_of_origin: "USA") }
    before_save(:titleize_product)

    private
    def titleize_product
      self.name = self.name.titleize
    end
  end
