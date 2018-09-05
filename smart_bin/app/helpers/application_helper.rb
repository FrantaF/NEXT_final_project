module ApplicationHelper

# calculate bin stats here
def individual_bin_level_per_hour(bin_id, num_of_hours)

   @dustbin_stat = DustbinStat.where('dustbin_id = "#{bin_id}"') 
   @fill_level_percentage = []    

   @dustbin_stat.each do |record|
      fill_level_id = record.fill_level_id
      @fill_level_percentage.push(FillLevel.find(fill_level_id).percentage.to_i)
   end   

    #generate hourly timeline
    @hourly_timeline = []
    (1..num_of_hours).each do |hour|      
      #IMPORTANT! WHEN YOU STORE STRING, TRAILING DOUBLE QUOTES WILL BE ATTACHED TO IT 
      #WHEN YOU PUSH TO ARRAY. THIS CAUSES AN ERROR IN THE CHART      
      @hourly_timeline.push(hour)
   end   
end

def time_to_fill_up_bin(bin_id)
   #how long does it take for a bin to fill up
   @dustbin_stat = DustbinStat.where('dustbin_id = "#{bin_id}"') 
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
end





end
