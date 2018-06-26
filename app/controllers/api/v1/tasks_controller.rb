module Api
	module V1
		class TasksController < ApiController
			before_action :set_user
			skip_before_action :verify_authenticity_token

			def index
				render json: {data: Task.all, status: 200}
			end

			def create
				begin
					unless task = Task.create(task_params)
						raise task.errors.full_messages.to_a.join(',')
					end
					render json: {data: task, status: 200}
				rescue => e 
					render json: {error: e}
				end
			end

			protected
			def set_user
				@user = current_person
			end
			def task_params
		      params[:task][:user_id] = current_user.id
		      params.require(:task).permit(:title, :description, :due_on, :user_id)
		    end
		end
	end
end