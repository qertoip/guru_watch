module ApplicationHelper

  # view model
  def vm
    @vm || @rm   # if view model is not set fallback to response model
  end

end
