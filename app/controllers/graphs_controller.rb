class GraphsController < ApplicationController
  before_action :set_graph, only: %w[show destroy query sparql export browse]

  def create
    @graph = Graph.new(graph_params)

    if @graph.save
      redirect_to @graph
    else
      render :new, status: :unprocessable_entity
    end
  end

  def browse
    @term = params[:term]
  end

  def sparql
    grapher = @graph.grapher
    result  = grapher.sparql(params[:query])

    render ResultSetComponent.new(result), layout: false
  end

  def export
    nt_content = @graph.triples.map { |triple| triple.to_s }.join("\n")

    send_data nt_content, type: 'text/nt; charset=utf-8; header=present',
                          disposition: "attachment; filename=#{@graph.name}.nt"
  end

  def new
    @graph = Graph.new
  end

  def destroy
    @graph.destroy

    redirect_to graphs_path
  end

  private

  def set_graph
    @graph = Graph.find(params[:id] || params[:graph_id])
  end

  def graph_params
    params.require(:graph).permit(:name, :graph_file)
  end
end
