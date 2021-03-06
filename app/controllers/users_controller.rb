class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :is_admin?, only: [:index]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if params[:id].present?
        @user = User.find(params[:id])
      else
        @user = current_user
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      if is_current_user_admin?
        if current_user.id == @user.id
          params.require(:user).permit(:parent_id, address: [:phone_number])
        else
          params.require(:user).permit(:parent_id,address: [:phone_number, :address_line, :street, :city, :state, :pin_code, :landmark])
        end
      else
        params.require(:user).permit(:parent_id,:avatar, address: [:phone_number, :address_line, :street, :city, :state, :pin_code, :landmark])
      end
    end

    def is_admin?
      # check if user is a admin
      # if not admin then redirect to where ever you want 
      redirect_to root_path unless current_user.is_admin 
    end
end
