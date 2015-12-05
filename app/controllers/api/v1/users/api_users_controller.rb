
class Api::V1::Users::ApiUsersController < Api::BaseApiController
  protect_from_forgery with: :null_session
  before_filter :find_user, only: [:show, :update, :delete]

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

  ##
  # Returns the list of all user
  #
  # GET /api/v1/users
  #
  # params:
  #   none
  #
  # = Examples
  #
  #   resp = conn.get("/api/v1/users/")
  #
  #   resp.code
  #   => 200
  #
  #   resp.body
  #   => [
  #      {
  #        "id": 1,
  #        "name": "Shivam Bansal",
  #        "created_at": "2015-12-05T10:22:49.419Z",
  #        "updated_at": "2015-12-05T10:22:49.419Z"
  #      },
  #      {
  #        "id": 3,
  #        "name": "Wankhede",
  #        "created_at": "2015-12-05T10:23:41.184Z",
  #        "updated_at": "2015-12-05T10:24:56.581Z"
  #      }
  #
  def index
    render json: User.all
  end

  ##
  # Returns the requested user
  #
  # GET /api/v1/users/:name
  #
  # params:
  #   none
  #
  # = Examples
  #
  #   resp = conn.get("/api/v1/users/Shivam Bansal")
  #
  #   resp.code
  #   => 200
  #
  #   resp.body
  #   => {
  #        "id": 1,
  #        "name": "Shivam Bansal",
  #        "created_at": "2015-12-05T10:22:49.419Z",
  #        "updated_at": "2015-12-05T10:22:49.419Z"
  #      }
  #
  #   resp = conn.get("/api/v1/users/bansal")
  #
  #   resp.code
  #   => 404
  #
  #   resp.body
  #   => 
  #
  def show
    render json: @user
  end

  ##
  # Creates a new user
  #
  # POST /api/v1/users/
  #
  # params:
  #   name: string
  #
  # = Examples
  #
  #   resp = conn.post("/api/v1/users/?name=Shivam Bansal")
  #
  #   resp.code
  #   => 200
  #
  #   resp.body
  #   => {
  #        "id": 1,
  #        "name": "Shivam Bansal",
  #        "created_at": "2015-12-05T10:22:49.419Z",
  #        "updated_at": "2015-12-05T10:22:49.419Z"
  #      }
  #
  #   resp = conn.post("/api/v1/users/?")
  #
  #   resp.code
  #   => 400
  #
  #   resp.body
  #   => 
  #
  def create
    @user = User.new
    @user.name = params[:name]
    if @user.save
      render json: @user
    else
       render nothing: true, status: :bad_request
    end
  end

  ##
  # Updates the requested user
  #
  # PUT /api/v1/users/:name
  #
  # params:
  #   new_name: string
  #
  # = Examples
  #
  #   resp = conn.put("/api/v1/users/Shivam?new_name=Shivam Bansal")
  #
  #   resp.code
  #   => 200
  #
  #   resp.body
  #   => {
  #        "id": 1,
  #        "name": "Shivam Bansal",
  #        "created_at": "2015-12-05T10:22:49.419Z",
  #        "updated_at": "2015-12-05T10:23:49.419Z"
  #      }
  #
  #   resp = conn.put("/api/v1/users/zxc?new_name=abc")
  #
  #   resp.code
  #   => 404
  #
  #   resp.body
  #   => 
  #
  #   resp = conn.put("/api/v1/users/Shivam Bansal?")
  #
  #   resp.code
  #   => 400
  #
  #   resp.body
  #   => 
  #
  def update
    @user.name = params[:new_name]
    if @user.save
        render json: @user
    else
        render nothing: true, status: :bad_request
    end
  end

  ##
  # Deletes the requested user
  #
  # DELETE /api/v1/users/:name
  #
  # params:
  #   none
  #
  # = Examples
  #
  #   resp = conn.delete("/api/v1/users/Shivam Bansal")
  #
  #   resp.code
  #   => 200
  #
  #   resp.body
  #   => 
  #
  #   resp = conn.delete("/api/v1/users/zxc")
  #
  #   resp.code
  #   => 404
  #
  #   resp.body
  #   => 
  #
  def delete
    if @user.destroy
      render nothing: true, status: :ok
    end
  end

  private
    def find_user
     @user = User.find_by_name(params[:name])
     render nothing: true, status: :not_found unless @user.present?
    end
end

