class Brewery < ActiveRecord::Base
  include RatingAverage
  has_many :beers, :dependent => :destroy
  has_many :ratings, :through => :beers

  validates :name, presence: true

  validates :year, numericality: { greater_than_or_equal_to: 1042,
                                    only_integer: true }

  validate :check_year_is_not_in_the_future

  def check_year_is_not_in_the_future
    if year.present? && year > Time.now.year
      errors.add(:year, "can't be in the future")
    end
  end

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
    puts "number of ratings #{ratings.count}"
  end

end

