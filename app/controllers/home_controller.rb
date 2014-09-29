class HomeController < ApplicationController

	def index
    @meeting_rooms = MeetingRoom.all
  end

  def new
    @meeting_room = MeetingRoom.new
  end
  
end
