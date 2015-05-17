class CommentsController < ApplicationController
  def create
    @commentable = params[:klass].classify.constantize.find(params[:commentable_id])
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user
    @new_comment = Comment.new
    authorize @comment
    if !@comment.save!
      flash[:error] = 'There was an error saving the post. Please try again.' 
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    authorize @comment

    if !@comment.destroy
     flash[:error] = "Comment couldn't be deleted. Pleae try again."
    end

   end

  private

  def comment_params
    params.require(:comment).permit(:title, :comment)
  end

end
