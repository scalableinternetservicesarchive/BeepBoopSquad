class UsersController < ApplicationController
  skip_forgery_protection
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to '/', notice: "User was successfully created. Please log in." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def prd_seed_users
    require_relative '../../db/controller_user_seeding'
    if params[:seed_id].nil?
      input = ""
    else
      input = params[:seed_id]
    end
    resp = seed_users(input)
    if !resp
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Unsuccessful seed. File users" + input.to_s + ".csv doesn't exist" }
        format.json { render json: {"message": "Unsuccessful seed. File users" + input.to_s + ".csv doesn't exist"  }, status: :unprocessable_entity}
      end
    else
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Seeded users with file users" + input.to_s + ".csv" }
      format.json { render json: {"message": "Seeded users with file users" + input.to_s + ".csv" }, status: :created }
    end
  end
  end

  def destroy_users
    User.destroy_all
    respond_to do |format|
      format.html { redirect_to root_path, notice: "All users were destroyed" }
      format.json { render json: {"message": "All users were destroyed" }, status: :created }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :cash_balance, :password)
    end
end
