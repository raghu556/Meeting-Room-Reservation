class CreateMeetingRooms < ActiveRecord::Migration
  def change
    create_table :meeting_rooms do |t|
      t.string :name
    end
  end
end
