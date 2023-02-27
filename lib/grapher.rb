# Process an RDF file
class Grapher
  attr_reader :graph, :prefixes

  def self.from_file(file)
    prefixes = {}

    graph = RDF::Repository.new do |repository|
      rdf_reader = RDF::Reader.for(:rdf).new(file) do |reader|
        repository.send(:insert_statements, reader)

        nil
      end

      prefixes = rdf_reader.prefixes

      rdf_reader
    end

    new(graph, prefixes:)
  end

  def self.load_test
    graph = RDF::Reader.open('mmdb_ontology_rcs.rdf')

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

  def initialize(graph, prefixes: {})
    @graph    = graph
    @prefixes = prefixes
  end

  def sparql(query)
    sparql_query = SPARQL.parse(query)
    results      = @graph.query(sparql_query)

    columns = results.variable_names.map(&:to_s)
    rows    = results.map { |row| row.to_h.values.map(&:to_s) }

    { results: results.size, columns:, rows:}
  end
end
