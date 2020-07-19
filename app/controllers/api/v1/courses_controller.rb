module Api
  module V1
    class CoursesController < ApplicationController
      before_action :jwt_authenticate
      before_action :set_course, only: [:show, :edit]

      def create
        course = Course.new(course_parameters)
        if course.save
          render json: CourseSerializer.new(course).to_json, status: 200
        else
          render json: course.errors, status: 400
        end
      end

      def edit
        if @course.update(course_parameters)
          render json: CourseSerializer.new(@course).to_json, status: 200
        else
          render json: @course.errors, status: 400
        end
      end

      def list
        render json: @current_user.courses, each_serializer: CourseSerializer, status: 200
      end

      def show
        render json: CourseSerializer.new(@course).to_json, status: 200
      end

      private

      def course_parameters
        params.permit(
          :name
        ).merge(
          user_id: @current_user.id
        )
      end

      def set_course
        @course = Course.find_by(id: params[:id])
        if !@course || @course.user_id != @current_user.id
          error('Course does not exist or you do not have access to it')
        end
      end
    end
  end
end