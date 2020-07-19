module Api
  module V1
    class AssignmentsController < ApplicationController
      before_action :jwt_authenticate
      before_action :set_assignment, only: [:show, :edit]

      def create
        assignment = Assignment.new(assignment_params)
        if assignment.save
          render json: AssignmentSerializer.new(assignment).to_json, status: 200
        else
          render json: assignment.errors, status: 400
        end
      end

      def edit
        if @assignment.update(assignment_params)
          render json: AssignmentSerializer.new(@assignment).to_json, status: 200
        else
          render json: @assignment.errors, status: 400
        end
      end

      def show
        render json: AssignmentSerializer.new(@assignment).to_json, status: 200
      end

      def list
        assignments = Assignment
          .where(course_id: @current_user.courses)
          .order(due_date: :DESC)
          
        render json: assignments, each_serializer: AssignmentSerializer, status: 200
      end

      private

      def assignment_params
        params.permit(
          :due_date,
          :title,
          :description,
          :course_id
        )
      end

      def set_assignment
        @assignment = Assignment.find_by(id: params[:id])
        if !@assignment || @assignment.course.user_id != @current_user.id
          error('Assignment does not exist or you do not have access to it')
        end
      end
    end
  end
end