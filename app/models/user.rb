class User < ActiveRecord::Base
  include RatingAverage

  has_many :ratings, :dependent => :destroy
  has_many :beers, through: :ratings
  has_many :memberships, :dependent => :destroy

  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 15 }

  has_secure_password


end
