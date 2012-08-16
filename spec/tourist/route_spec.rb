require_relative '../spec_helper'
require_relative '../../lib/tourist/route'

describe Route do
  before do
    opts = {from: ?A, to: ?B, departure: "09:00", arrival: "15:45", 
            price: 300.00}
    @it = Route.new opts
  end

  it "has accessors for its attributes" do
    [@it.from, @it.to, @it.price].must_equal [?A, ?B, 300]
    @it.departure.must_equal "09:00"
    @it.arrival.must_equal "15:45"
    @it.journey_hrs.must_equal 6.75
  end
end # describe Route

describe "#+" do
  before do
    opts1 = {from: ?A, to: ?B, departure: "09:00", arrival: "10:00", 
             price: 100.00}
    r1 = Route.new opts1
    opts2 = {from: ?B, to: ?Z, departure: "11:00", arrival: "12:00", 
             price: 200.00}
    r2 = Route.new opts2
    @actual = r1 + r2
  end

  it "returns a new route with added attrs" do
    @actual.from.must_equal ?A
    @actual.to.must_equal ?Z
    @actual.departure.must_equal "09:00"
    @actual.arrival.must_equal "12:00"
    @actual.price.must_equal 300
  end

  it "sets the journey hrs as only the time actually travelled" do
    @actual.journey_hrs.wont_equal 3.0
    @actual.journey_hrs.must_equal 2.0
  end
end # describe #+

describe "#==" do
  before do
    opts1 = {from: ?A, to: ?B, departure: "09:00", arrival: "10:00", 
             price: 100.00}
    @r1 = Route.new opts1
    @r2 = Route.new opts1
  end

  it "compares two objects based on their attribute values only" do
    @r1.must_equal @r2
  end
end

