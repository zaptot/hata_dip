class PostsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_post, only: [:show]
  before_action :set_user_post, only: %i[edit update destroy]
  before_action :build_form, only: %i[new]
  before_action :build_user_form, only: %i[edit]
  before_action :authenticate_user!, only: %i[create edit update destroy new]

  HOME_FILTER_PARAMS = %i[city street floor rooms_count].freeze
  ONLY_TRUE_FILTER_OPTIONS = %i[furniture fridge tv internet balcony conditioner].freeze
  POST_FILTER_FIELDS = %i[string].freeze

  # GET /posts
  # GET /posts.json
  def index
    @params = params[:post]&.slice(*(HOME_FILTER_PARAMS | ONLY_TRUE_FILTER_OPTIONS | POST_FILTER_FIELDS)) || {}
    @params.slice(*ONLY_TRUE_FILTER_OPTIONS).each { |k, v| @params.delete(k) if v == '0'}
    homes = Home.filter(@params.slice(*(HOME_FILTER_PARAMS | ONLY_TRUE_FILTER_OPTIONS)))
    @posts = Post
    if @params[:string]
      @posts = @posts.where("description LIKE '%#{@params[:string]}%' OR title LIKE '%#{@params[:string]}%'")
    end
    @posts = @posts.joins(:home).merge(homes)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post.increment!(:views)
  end

  # GET /posts/1/edit
  def edit; end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # POST /posts
  # POST /posts.json
  def create
    @post_form = PostForm.new(
      params.require(:post_form).permit(*(PostForm::HOUSE_FIELDS + PostForm::POST_FIELDS + [{photos:[]}])).merge(user: current_user)
    )

    respond_to do |format|
      if @post_form.save
        format.html { redirect_to posts_url, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: posts_url }
      else
        format.html { render :new }
        format.json { render json: @post_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def my_posts
    @posts = Post.where(user: current_user)
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_user_post
    @post = Post.where(user: current_user)
                .find(params[:id])
  end

  def build_form
    @post_form = PostForm.new
  end

  def build_user_form
    post = set_post
    home = post.home
    params = post.as_json.merge(home.as_json).with_indifferent_access
    @post_form = PostForm.new(params.slice(*(PostForm::HOUSE_FIELDS | PostForm::POST_FIELDS)))
  end

  def post_params
    params.require(:post)
          .permit(*POST_FIELDS)
          .merge(user: current_user)
  end
end
