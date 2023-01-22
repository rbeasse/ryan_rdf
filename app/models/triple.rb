# Stores all graph triples
class Triple < ApplicationRecord
  belongs_to :graph

  # Create a triple from an RDF statement
  def self.from_statement(statement)
    subject   = RDF::NTriples.serialize(statement.subject)
    predicate = RDF::NTriples.serialize(statement.predicate)
    object    = RDF::NTriples.serialize(statement.object)

    new(subject:, predicate:, object:)
  end

  def to_s
    "#{subject} #{predicate} #{object} ."
  end
end
