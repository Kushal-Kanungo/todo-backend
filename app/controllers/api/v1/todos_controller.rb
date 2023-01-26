module Api
  module V1
    class TodosController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response
      # rescue_from ActiveRecord::RecordInvalid, with: :invalid_record_response

      def index
        @todos = Todo.all
        render json: @todos
      end

      def new_tasks
        @todos = Todo.where(status: 'NEW')
        render json: @todos
      end

      def inprogress_tasks
        @todos = Todo.where(status: 'INPROGRESS')
        render json: @todos
      end

      def done_tasks
        @todos = Todo.where(status: 'DONE')
        render json: @todos
      end

      def create
        @todo = Todo.new(todo_data_new)
        @todo.status = 'NEW'
        if @todo.save
          render json: @todo
        else
          render json: { errors: @todo.errors }, status: 400
        end
      end

      def update
        @todo = Todo.find(params[:id])
        # @todo.completion_date = Time.now if todo_data_update.status == 'Done'
        @todo.update(todo_data_update)
        @todo.update(completion_date: Time.now) if @todo.status == 'DONE'
        render json: @todo
      end

      def destroy
        @todo = Todo.find(params[:id])
        @todo.destroy
        render json: { "success": true }
      end

      private

      def todo_data_update
        params.require(:todo).permit(:title, :description, :priority, :status)
      end

      def todo_data_new
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
