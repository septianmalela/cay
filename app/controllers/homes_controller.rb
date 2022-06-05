class HomesController < ApplicationController
  def index
    @q = User.ransack(params[:q])
    @users = @q.result.without_self(current_user)
  end
end