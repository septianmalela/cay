class HomesController < ApplicationController
  def index
    @q = User.ransack(params[:q])
    @users = @q.result
  end
end