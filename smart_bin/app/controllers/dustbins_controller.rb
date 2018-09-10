class DustbinsController < ApplicationController

    def update
        response = HTTParty.get('http://192.168.1.192:1234/bins')
        json = JSON.parse(response.body)
        
        @bin = Dustbin.find(params[:id])
        fill = (json["fill level"]*10).to_f.round + 1

        @bin.fill_level_id = fill

        if @bin.fill_level_id == 1
            @bin.last_collected = Time.now()
        end

        @bin.save

        redirect_to users_path
    end

end
