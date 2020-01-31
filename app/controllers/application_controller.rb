class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
    flash[:notice] = "Signed in successfully."
    user_path(current_user)
  end
  def after_sign_out_path_for(resource)
    flash[:notice] = "Signed out successfully."
    root_path
  end
  def after_sign_up_path_for(resources)
  	books_path(current_user)
  end
 


 

protected
  def configure_permitted_parameters
    # サインアップ時にnameのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :postcode, :prefecture_code, :address_city, :address_street, :address_building])
    # アカウント編集の時にnameとprofileのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:email])
  end
end