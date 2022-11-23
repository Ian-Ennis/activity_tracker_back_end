class ActivitiesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        @user = User.find(@user.id)
        @activities = @user.activities
        render json: @activities
    end

    def create
        activity = Activity.create!(user_id: params[:user_id], name: params[:name], date: params[:date], minutes: params[:minutes], notes: params[:notes])
        if activity.valid?
            render json: activity, status: :created
        else
            render json: {error: "Activity could not be created"}, status: :unprocessable_entity
        end
    end

    def destroy
        activity = find_activity
        activity.destroy
        head :no_content
    end

    private
    
    def activity_params
        params.permit(:user_id, :date, :name, :yoga_type, :workout, :distance, :minutes, :notes)
    end

    def find_activity
        Activity.find(params[:id])
    end

    def render_not_found_response
        render json: { error: "Activity not found" }, status: :not_found
    end

end