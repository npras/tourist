require_relative "tourist/version"
require_relative "tourist/route"

module Tourist
  class Run

    attr_reader :routes

    def initialize
      #opts1 = {from: ?a, to: ?b, departure: "09:00", arrival: "10:00", 
               #price: 100.00}
      #r1 = Route.new opts1
      #opts2 = {from: ?b, to: ?z, departure: "11:00", arrival: "12:00", 
               #price: 200.00}
      #r2 = Route.new opts2
      #opts3 = {from: ?a, to: ?c, departure: "08:00", arrival: "15:00", 
               #price: 2000.00}
      #r3 = Route.new opts3
      #@routes = [r1, r2, r3]
    end # def initialize

    def get_route(from, to, routes=@routes)
      prospects = prospect_routes(from, routes)

      if prospects.empty?
        fail NoProspectError, "No route available leading from: #{from}"
      end

      # check breadth-wise
      match = prospects.find do |route|
        (route.to == to)
      end
      return match unless match.nil?

      # check recursively
      prospects.each do |route|
        current_to = route.to
        if current_to == to
          #return Route.new(from: from, to: route.to, departure: departure, arrival: route.arrival, price: )
        end
      end # prospects.eash

    end # def get_route

    def prospect_routes(from, routes=@routes)
      routes.find_all { |r| r.from == from }
    end

  end # class Run

  class NoProspectError < StandardError; end
end # module Tourist

if __FILE__ == $0
  Tourist::Run.new.get_route ?A, ?B
end
