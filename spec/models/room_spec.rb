# frozen_string_literal: true

require "rails_helper"

RSpec.describe ::Room, type: :model do
  it "Create a room" do
    user = create(:user_1)
    room = create(:room_1, user: user)

    expect(room.room_type).to eq("house")
  end
end
