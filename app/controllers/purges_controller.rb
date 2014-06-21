class PurgesController < ApplicationController

  def index
    @purges = Purge.all
  end

end
