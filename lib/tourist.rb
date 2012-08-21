require_relative "tourist/graph"

module Tourist
  class Run
    InputFile = 'data/ip.txt'

    attr_reader :graph
    
    def initialize
      @graph = Tourist::Graph.new
    end

    def prepare
      File.foreach(InputFile) do |line|
        from, to, departure, arrival, price = *line.split
        graph.add from, to, price
      end
    end

  end # class Run
end # module Tourist

if __FILE__ == $0
  Tourist::Run.new.prepare
end
