class CommentsController < ApplicationController
  def create
    Rails.logger.debug "Comment params: #{params.inspect}"

    # Use :id because the params contain "id"=>"6", not "showu_id"
    @showu = Showu.find(params[:id])

    @comment = @showu.comments.build(body: params[:body], user: current_user)

    if @comment.save
      render json: {
        comment: {
          body: @comment.body,
          user_username: @comment.user.username
        },
        comments_count: @showu.comments.count
      }
    else
      render json: { error: 'Failed to create comment' }, status: :unprocessable_entity
    end
  end
end
