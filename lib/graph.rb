# Process an RDF file
class Graph
  @graph_location = 'mmdb_ontology_rcs.rdf'

  def self.from_file
    @from_file ||= RDF::Graph.load(@graph_location)
  end

  def self.file_location
    @graph_location
  end

  def initialize
    @graph = Graph.from_file
  end

  def sparql(query)
    sparql_query = SPARQL.parse(query)
    results      = @graph.query(sparql_query)

    columns = results.variable_names.map(&:to_s)
    rows    = results.map { |row| row.to_h.values.map(&:to_s) }

    { results: results.size, columns:, rows: }
  end
end
