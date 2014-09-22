class BookingsController < ApplicationController
  respond_to :html, :xml, :json
  
  before_action :find_meeting_room

  def index
    @bookings = Booking.where("meeting_room_id = ? AND end_time >= ?", @meeting_room.id, Time.now).order(:start_time)
    respond_with @bookings
  end

  def new
    @booking = Booking.new(meeting_room_id: @meeting_room.id)
  end

  def create
    @booking =  Booking.new(params[:booking].permit(:meeting_room_id, :start_time, :length))
    @booking.meeting_room = @meeting_room
    if @booking.save
      redirect_to meeting_room_bookings_path(@meeting_room, method: :get)
    else
      render 'new'
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def destroy
    @booking = Booking.find(params[:id]).destroy
    if @booking.destroy
      flash[:notice] = "Booking: #{@booking.start_time.strftime('%e %b %Y %H:%M%p')} to #{@booking.end_time.strftime('%e %b %Y %H:%M%p')} deleted"
      redirect_to meeting_room_bookings_path(@meeting_room)
    else
      render 'index'
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    # @booking.meeting_room = @meeting_room

    if @booking.update(params[:booking].permit(:meeting_room_id, :start_time, :length))
      flash[:notice] = 'Your booking was updated succesfully'

      if request.xhr?
        render json: {status: :success}.to_json
      else
        redirect_to meeting_room_bookings_path(@meeting_room)
      end
    else
      render 'edit'
    end
  end

  private

  def save booking
    if @booking.save
        flash[:notice] = 'booking added'
        redirect_to meeting_room_booking_path(@meeting_room, @booking)
      else
        render 'new'
      end
  end

  def find_meeting_room
    if params[:meeting_room_id]
      @meeting_room = MeetingRoom.find_by_id(params[:meeting_room_id])
    end
  end

end
