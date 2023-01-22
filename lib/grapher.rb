# Process an RDF file
class Grapher
  attr_reader :graph

  def self.from_file(file)
    graph = RDF::Repository.new do |repository|
      RDF::Reader.for(:rdf).new(file) do |reader|
        repository.send(:insert_statements, reader)

        nil
      end
    end

    new(graph)
  end

  def self.from_triples(triples)
    rdf_graph = RDF::Graph.new do |graph|
      triples.each do |triple|
        RDF::NTriples::Reader.new(triple.to_s) { |reader| graph << reader }
      end
    end

    new(rdf_graph)
  end

  def initialize(graph)
    @graph = graph
  end

  def sparql(query)
    sparql_query = SPARQL.parse(query)
    results      = @graph.query(sparql_query)

    columns = results.variable_names.map(&:to_s)
    rows    = results.map { |row| row.to_h.values.map(&:to_s) }

  { results: results.size, columns:, rows:}
  end
end
