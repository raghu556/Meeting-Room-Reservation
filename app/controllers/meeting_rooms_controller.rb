class MeetingRoomsController < ApplicationController

  def index
    @meeting_rooms = MeetingRoom.all
  end

  def new
    @meeting_room = MeetingRoom.new
  end

  def create
    @meeting_room = MeetingRoom.create(meeting_room_params)
    if @meeting_room.save
      name = @meeting_room.name
      redirect_to meeting_rooms_path
      flash[:notice] = "#{name} created"
    else
      render 'new'
      flash[:error] = "Unable to create meeting room. Please try again"
    end
  end

  def destroy
    @meeting_room = MeetingRoom.find(params[:id])
    @meeting_room.destroy
    redirect_to meeting_rooms_path
  end

  def edit
    @meeting_room = MeetingRoom.find(params[:id])
  end

  def update
    @meeting_room = MeetingRoom.find(params[:id])
    @meeting_room.update meeting_room_params
    if @meeting_room.save
      flash[:notice] = "Your meeting room was updated succesfully"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

    def meeting_room_params
      params.require(:meeting_room).permit(:name, :delete)
    end

end
