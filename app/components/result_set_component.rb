class ResultSetComponent < ViewComponent::Base
  def initialize(results)
    @headers = results[:columns]
    @rows    = results[:rows]
  end
end
