
class Api::V1::Users::ApiUsersController < Api::BaseApiController
  skip_before_action :verify_authenticity_token
  before_filter :find_user, only: [:show, :update]

  before_filter only: :update do
    unless params[:new_name]
      render nothing: true, status: :bad_request
    end
  end

  before_filter only: :create do
    unless params[:name]
      render nothing: true, status: :bad_request
    end
  end

  def index
    render json: User.all
  end

  def show
    render json: @user
  end

  def create
    @user = User.new
    @user.name = params[:name]
    if @user.save
      render json: @user
    else
       render nothing: true, status: :bad_request
    end
  end

  def update
    @user.name = params[:new_name]
    if @user.save
        render json: @user
    else
        render nothing: true, status: :bad_request
    end
  end

  private
    def find_user
     @user = User.find_by_name(params[:name])
     render nothing: true, status: :not_found unless @user.present?
    end
end

