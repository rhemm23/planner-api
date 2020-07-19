module Api
  module V1
    class AssignmentCommentsController < ApplicationController
      before_action :jwt_authenticate
      before_action :set_assignment
      before_action :set_comment, only: [:edit, :show]

      def show
        render json: AssignmentCommentSerializer.new(@comment).to_json, status: 200
      end

      def list
        render json: @assignment.assignment_comments, each_serializer: AssignmentCommentSerializer, status: 200
      end

      def create
        comment = AssignmentComment.new(assignment_comment_params)
        if comment.save
          render json: AssignmentCommentSerializer.new(comment).to_json, status: 200
        else
          render json: comment.errors, status: 400
        end
      end

      def edit
        if @comment.update(assignment_comment_params)
          render json: AssignmentCommentSerializer.new(@comment).to_json, status: 200
        else
          render json: @comment.errors, status: 400
        end
      end

      private

      def assignment_comment_params
        params.permit(
          :comment
        ).merge(
          assignment_id: params[:id]
        )
      end

      def set_assignment
        @assignment = Assignment.find_by(id: params[:id])
        if !@assignment || @assignment.course.user_id != @current_user.id
          error('Assignment does not exist or you do not have access to it')
        end
      end

      def set_comment
        @comment = @assignment.assignment_comments.find_by(id: params[:comment_id])
        error('Comment does not exist') if !@comment
      end
    end
  end
end