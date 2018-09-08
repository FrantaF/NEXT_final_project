class UsersController < ApplicationController
   # before_action :authenticate_user!

   def chart
    # calculate bin stats here
    #assuming bin_id = 1   

    #fill level of individual bin per hour
    @dustbin_stat = DustbinStat.where("dustbin_id = '1'") 
    @fill_level_percentage = [] 
    
    @dustbin_stat.each do |record|
      fill_level_id = record.fill_level_id
      @fill_level_percentage.push(FillLevel.find(fill_level_id).percentage.to_i)
    end

    #generate hourly timeline
    @hourly_timeline = []
    (1..24).each do |hour|      
      #IMPORTANT! WHEN YOU STORE STRING, TRAILING DOUBLE QUOTES WILL BE ATTACHED TO IT 
      #WHEN YOU PUSH TO ARRAY. THIS CAUSES AN ERROR IN THE CHART      
      @hourly_timeline.push(hour)
    end


    #how long does it take for a bin to fill up
    count = 0 
    @filled_up_time = []
    @dustbin_stat.each do |record|
      fill_level = record.fill_level_id      
      if fill_level == 1
        @filled_up_time.push(count)
        count = 0
      end
      count += 1
    end

    #generate timeline 
    @record_num = []
    (1..@filled_up_time.length).each do |number| 
      @record_num.push(number)
    end

    #fill rate per hour of an individual bin
    @fill_up_rate = [0]
    (1..@fill_level_percentage.length).each do |index|      

      if @fill_level_percentage[index].to_i == 0
        fill_rate = 0
        
      else
        fill_rate = @fill_level_percentage[index].to_i - @fill_level_percentage[index-1].to_i
        @fill_up_rate.push(fill_rate)      
      end

    end


  end


  def home

  end


  def create
  end 

  def index

    @geojson = Array.new

    if current_user.admin?
      @dustbins = Dustbin.all.order("fill_level_id DESC")
    elsif current_user.user?
      @dustbins = current_user.dustbins.order("fill_level_id DESC")
    end

    @dustbins.each do |d|
      if d.fill_level_id > 7
        @geojson << {lng: d.latitude.to_f, lat: d.longitude.to_f}
      end
    end

    respond_to do |format|
      format.html
      format.json { render json: @geojson }
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


