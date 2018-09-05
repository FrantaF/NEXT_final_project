class UsersController < ApplicationController
   # before_action :authenticate_user!

   def testing_chart
    # calculate bin stats here
    #assuming bin_id = 1 
    #FillLevel.where("dustbin_id LIKE ?", "%#{params[:user][:location]}%")
    
   end


   def home

   end

   
   def create
   end 

   def index
    if current_user.admin?
        @dustbins = Dustbin.all
    elsif current_user.user?
        @dustbins = current_user.dustbins.order("fill_level_id DESC")
    end
   end

   def dashboard
   end

   def analyic
   end

   def profile
   end

   def employe_profiles

   end


end


