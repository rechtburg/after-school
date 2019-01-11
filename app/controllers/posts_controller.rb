class PostsController < ApplicationController
  before_action :require_sign_in!, only: [:show, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :add_comment, :destroy]

  # GET /posts
  def index
    @categories = Category.all.includes(:posts)
  end

  # GET /posts/1
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    logger.debug('params')
    logger.debug(post_params)
    @post = Post.new(title: post_params[:title], description: post_params[:description],
                      body: post_params[:body], category_id: post_params[:category_id]&.to_i,
                      user_id: @current_user.id, point: post_params[:point]&.to_i)
    logger.debug(@post.inspect)
    if((@current_user.point - post_params[:point]&.to_i) < 0)
      respond_to do |format|
        flash[:alert] = "You don't have enough points"
        format.html { render :new }
      end
    else
      @current_user.point -= post_params[:point]&.to_i
      if @post.save
        logger.debug @post.errors.inspect
        @current_user.save!
        flash[:notice] = 'Post was successfully created.'
        redirect_to mypage_path
      else
        respond_to do |format|
          format.html { render :new }
        end
      end
    end
  end

  # PATCH/PUT /posts/1
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

  def comment
    @comment = Comment.new(content: params[:content], post_id: params[:post_id], user_id: params[:user_id])
    @comment.save
    redirect_to action: "show", id: @comment.post_id
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :description, :body, :point, :category_id, :comment, :content, :post_id, :user_id)
    end
end
