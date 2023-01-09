class SparqlController < ApplicationController
  def index; end

  def sparql
    @graph = Graph.new
    result = @graph.sparql(params[:query])

    render ResultSetComponent.new(result), layout: false
  end
end
