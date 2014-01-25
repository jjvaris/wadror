module RatingAverage

  def average_rating
    average = 0
    ratings.each { |r| average += r.score }
    return average / ratings.count
  end

end