class UsersController < ApplicationController
	
	before_action :authenticate_user, only: [:edit, :update]
	
	def new
		@user = User.new
	end
	
	def create
		@user = User.new(user_params)
		@user.image_string = "default_user_image.png"
		
		if @user.save
			redirect_to sessions_new_path, success: "登録完了"
		else
			flash[:danger] = "登録失敗"
			render :new
		end
	end
	
	def edit
		@user = User.find(params[:id])
	end
	
	def update
		@user = User.find(params[:id])
		
		if @user.update(user_params)
			redirect_to recipes_path
		else
			render :edit
		end
	end
	
	
	private
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :image_string)
	end
end
