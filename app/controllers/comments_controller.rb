class CommentsController < ApplicationController
  
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_back(fallback_location: root_path) }
      else
        format.html { redirect_back(fallback_location: root_path) }
      end
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :user_id, :post_id)
    end
end
