class HomeController < ApplicationController
  before_action :set_home, only: [:show]
  before_action :set_user_home, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: %i[create edit update destroy new]

  PERMITED_PARAMS = (%i[city street house_number index_number floor
                       rooms_count space build_year furniture fridge
                       tv internet balcony conditioner] + [{ photos: [] }]).freeze
  def show; end

  def edit; end

  def index
    @params = process_params
    @params.slice(*PostsController::ONLY_TRUE_FILTER_OPTIONS).each { |k, v| @params.delete(k) if v == '0'}
    @homes = Home.filter(@params).paginate(page: params[:page], per_page: 15)
  end

  def my_homes
    @homes = index.where(user: current_user)
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

  def set_user_home
    @home = Home.where(user: current_user)
                .find(params[:id])
  end

  def home_params
    params.require(:home)
          .permit(*PERMITED_PARAMS)
  end

  def process_params
    params_keys = PostsController::HOME_FILTER_PARAMS |
                  PostsController::ONLY_TRUE_FILTER_OPTIONS |
                  PostsController::POST_FILTER_FIELDS
    params[:post]&.slice(*params_keys) || {}
  end
end
