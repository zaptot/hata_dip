class HomeController < ApplicationController
  before_action :set_home, only: [:show, :edit, :update, :destroy]

  PERMITED_PARAMS = %i[city street house_number index_number floor
                       rooms_count space build_year furniture fridge
                       tv internet balcony conditioner].freeze
  def show
  end

  def index
    @homes = Home.all
  end

  def my_homes
    @homes = Home.where(user: current_user)
  end

  def create
    @home = Home.new(home_params.merge(user: current_user))

    respond_to do |format|
      if @home.save
        format.html { redirect_to @home, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @home }
      else
        format.html { render :new }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @home = Home.new
  end

  def edit
  end

  def update
    respond_to do |format|
      if @home.update(home_params)
        format.html { redirect_to @home, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @home }
      else
        format.html { render :edit }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @home.destroy
    respond_to do |format|
      format.html { redirect_to home_index_path, notice: 'Home was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_home
    @home = Home.find(params[:id])
  end

  def home_params
    params.require(:home)
          .permit(*PERMITED_PARAMS)
  end
end
