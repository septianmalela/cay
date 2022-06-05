# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user = User.find_by(email: params[:user][:email])
    if user&.valid_password?(params[:user][:password])
      sign_in(resource_name, user)
      flash[:notice] = 'Login Successfully!'
      redirect_to root_path
    else
      flash[:alert] = 'Email or Password is wrong!'
      redirect_to new_user_session_path
    end
  end

  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    flash[:notice] = 'Sign Out Successfully!'
    yield if block_given?
    redirect_to new_user_session_path
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # def after_sign_out_path_for(resource_or_scope)
  #   new_user_session_path
  # end

  # def after_sign_in_path_for(resource_or_scope)
  #   root_path
  # end
end
