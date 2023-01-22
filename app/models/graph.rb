class Graph < ApplicationRecord
  attr_accessor :graph_file

  has_many :triples, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :original_file, :generated_at, presence: true

  before_validation :save_graph_file

  def grapher
    @grapher ||= Rails.cache.fetch(cache_slug) do
      Grapher.from_triples(triples)
    end
  end

  def cache_slug
    "grapher_#{id}"
  end

  private

  def save_graph_file
    grapher = Grapher.from_file(graph_file.tempfile)

    grapher.graph.each_statement do |statement|
      triples << Triple.from_statement(statement)
    end

    self.original_file = graph_file.original_filename
    self.generated_at = Time.now
  end
end
