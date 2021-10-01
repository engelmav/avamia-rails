class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :is_authenticated, only: [:create]

  def create
    @resource = User.new resource_params
    if @resource.save
      render :json => { success: true, data: @resource, message: "User Created Successfully" }, status: 200
    else
      render :json => { success: false, errors:  @resource.errors.full_messages.to_sentence}, status: 400
    end
  end

  private

  def resource_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end