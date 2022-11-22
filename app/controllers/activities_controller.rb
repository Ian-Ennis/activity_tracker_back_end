class ActivitiesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        puts "++++ Activities: in index"
        puts "params:"
        puts params
        activity = Activity.find_by!(user_id: params[:user_id])
        puts activity
        render json: activity, status: :ok
    end

    def show 
        puts "++++ Activities: in show"
        render json: @activity
    end

    def create
        activity = Activity.create!(user_id: params[:user_id], date: params[:date], minutes: params[:minutes], notes: params[:notes])
        if activity.valid?
            render json: activity, status: :created
        else
            render json: {error: "Activity could not be created"}, status: :unprocessable_entity
        end
    end

    def destroy
        puts "++++ Activities: in destroy"
        activity = find_activity
        activity.destroy
        head :no_content
    end

    private
    
    def activity_params
        puts "+++ Activities: in activity_params"
        params.permit(:user_id, :date, :name, :yoga_type, :workout, :distance, :minutes, :notes)
        puts "+++ Activities: leaving activity_params"
    end

    def find_activity
        puts "++++ Activities: in find_activity"
        Activity.find(params[:id])
    end

    def render_not_found_response
        puts "++++ Activities: in render_not_found_response"
        render json: { error: "Activity not found" }, status: :not_found
    end

end