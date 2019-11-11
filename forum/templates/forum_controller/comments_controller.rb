class Forum::CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :new, :destroy]


  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  def create
    @comment = current_user.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to topic_url(@comment.topic_id), notice: 'Comment was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /comments/1
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to topic_url(@comment.topic_id), notice: 'Comment was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to topic_url(@comment.topic_id), notice: 'Comment was successfully destroyed.' }
    end
  end

  def upvote
    @comment = Comment.find(params[:id])
    @comment.upvote_by current_user
    redirect_to topic_url(@comment.topic_id)
  end

  def downvote
    @comment = Comment.find(params[:id])
    @comment.downvote_by current_user
    redirect_to topic_url(@comment.topic_id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :topic_id, :user_id)
    end
end
