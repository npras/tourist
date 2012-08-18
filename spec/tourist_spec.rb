require_relative './spec_helper'
require_relative '../lib/tourist'

describe "#get_route" do
  before do
    @it = Tourist::Run.new
    opts1 = {from: ?a, to: ?c, departure: "08:00", arrival: "15:00", 
             price: 2000.00}
    r1 = Route.new opts1
    opts2 = {from: ?b, to: ?c, departure: "08:00", arrival: "15:00", 
             price: 20.00}
    r2 = Route.new opts2
    @routes = r1, r2
  end

  it "fails if there is no route available from the given 'from'" do
    from, to = ?y, ?c
    ->{ @it.get_route(from, to, @routes) }.must_raise Tourist::NoProspectError
  end

  it "returns the correct route for a direct input" do
    from, to = ?a, ?c
    opts = {from: ?a, to: ?c, departure: "08:00", arrival: "15:00", 
             price: 2000.00}
    r = Route.new opts
    result = @it.get_route(from, to, @routes)
    result.must_equal r
  end
end # describe #get_route

describe "#prospect_routes" do
  before do
    @it = Tourist::Run.new
  end

  it "gets the prospective routes with matching 'from'" do
    opts1 = {from: ?a, to: ?b, departure: "09:00", arrival: "10:00", 
             price: 100.00}
    r1 = Route.new opts1
    opts2 = {from: ?b, to: ?z, departure: "11:00", arrival: "12:00", 
             price: 200.00}
    r2 = Route.new opts2
    opts3 = {from: ?a, to: ?c, departure: "08:00", arrival: "15:00", 
             price: 2000.00}
    r3 = Route.new opts3
    routes = r1, r2, r3

    from = ?a
    @it.prospect_routes(from, routes).length.must_equal 2
  end
end # describe #prospect_routes
