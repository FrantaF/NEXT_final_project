class UsersController < ApplicationController
   # before_action :authenticate_user!

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


