require 'time'

class Route

  attr_accessor :from, :to, :departure, :arrival, :price, :journey_hrs

  def initialize(opts)
    opts.each { |k,v| send("#{k}=", v) }
    @journey_hrs ||= get_journey_hrs
  end

  def +(other)
    opts = {from: from,
            to: other.to,
            departure: departure,
            arrival: other.arrival,
            journey_hrs: (@journey_hrs + other.journey_hrs),
            price: (self.price + other.price)}
    Route.new opts
  end

  def ==(other)
    
  end

  private
  def get_journey_hrs
    (Time.parse(arrival) - Time.parse(departure)) / (60 * 60)
  end
end # Route