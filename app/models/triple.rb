# Stores all graph triples
class Triple < ApplicationRecord
  belongs_to :graph

  scope :sub_classes, -> { where(predicate: '<http://www.w3.org/2000/01/rdf-schema#subClassOf>') }
  scope :labels, -> { where(predicate: '<http://www.w3.org/2000/01/rdf-schema#label>') }

  # Create a triple from an RDF statement
  def self.from_statement(statement)
    subject   = RDF::NTriples.serialize(statement.subject)
    predicate = RDF::NTriples.serialize(statement.predicate)
    object    = RDF::NTriples.serialize(statement.object)

    new(subject:, predicate:, object:)
  end

  def subject_uri_identifier
    subject.match(/<(.*)#(.*)>/)[2]
  end

  def object_uri_identifier
    object.match(/<(.*)#(.*)>/)[2]
  end

  def to_s
    "#{subject} #{predicate} #{object} ."
  end
end
