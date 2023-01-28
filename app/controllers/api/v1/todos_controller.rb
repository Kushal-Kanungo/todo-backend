# Controller for todo actions
module Api
  module V1
    # Controller for todo actions
    class TodosController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response

      def index
        @todos = Todo.all
      end

      def new_tasks
        @todos = Todo.where(status: 'NEW')
      end

      def inprogress_tasks
        @todos = Todo.where(status: 'INPROGRESS')
      end

      def done_tasks
        @todos = Todo.where(status: 'DONE')
      end

      def show
        @todo = Todo.find(params[:id])
      end

      def create
        @todo = Todo.new(todo_data_new_param)
        @todo.status = 'NEW'
        return if @todo.save

        render json: { errors: @todo.errors }, status: 400
      end

      def update
        @todo = Todo.find(params[:id])
        @todo.update(todo_data_update_param)
        @todo.update(completion_date: Time.now) if @todo.status == 'DONE'
      end

      def destroy
        @todo = Todo.find(params[:id])
        @todo.destroy
        render json: { "success": true }
      end

      private

      def todo_data_update_param
        params.require(:todo).permit(:title, :description, :priority, :status)
      end

      def todo_data_new_param
        params.require(:todo).permit(:title, :description, :priority)
      end

      def record_not_found_response
        render json: { error: 'Task not found' }, status: :not_found
      end

      # def invalid_record_response
      #   render json: { errors: @todo.errors }, status => 400
      # end
    end
  end
end
