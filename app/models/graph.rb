class Graph < ApplicationRecord
  attr_accessor :graph_file

  has_many :triples, dependent: :destroy
  has_many :prefixes, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :iri, :original_file, :generated_at, presence: true

  before_validation :generate_graph, if: -> { graph_file.present? }

  def grapher
    @grapher ||= Rails.cache.fetch(self) do
      Grapher.from_triples(triples)
    end
  end

  def prefix_string
    "#{prefixes.map(&:to_s).join("\n")}\n\n"
  end

  # Create a heirachy of all the subjects in the graph
  #
  # 1. Build a map of all potential parents and their children
  # 2. Find all the top level subjects by removing all URI's that are subclasses of another
  # 3. Find all the children of the top level subjects, and their children, and so on
  def heirachy
    child_map = triples.sub_classes.each_with_object({}) do |triple, hsh|
      hsh[triple.object_uri_identifier] ||= []
      hsh[triple.object_uri_identifier] << triple.subject_uri_identifier
    end

    child_map[:top_level] = child_map.keys - child_map.values.flatten

    recursive_heirachy(:top_level, child_map)
  end

  private

  def graph_labels
    @graph_labels ||= triples.labels.to_h do |triple|
      [triple.subject_uri_identifier, triple.object[1..-2]]
    end
  end

  def recursive_heirachy(subject, child_map)
    children = child_map[subject]

    return if children.blank?

    children.each_with_object({}) do |child_subject, hsh|
      label = graph_labels[child_subject] || child_subject

      hsh[[label, child_subject]] = recursive_heirachy(child_subject, child_map)
    end
  end

  def generate_graph
    graph_tripples_and_prefixes

    self.original_file = graph_file.original_filename
    self.generated_at  = Time.now
  end

  def graph_tripples_and_prefixes
    grapher = Grapher.from_file(graph_file.tempfile)

    grapher.graph.each_statement do |statement|
      triples << Triple.from_statement(statement)
    end

    grapher.prefixes.each { |prefix, uri| prefixes.build(prefix:, uri:) }
  end
end
