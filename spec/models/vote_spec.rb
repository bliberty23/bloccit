require 'rails_helper'

describe Vote do
  describe "validations" do
    describe "value validation" do
      it "only allows -1 or 1 as values" do
        v_up = Vote.new(value: 1)
        expect( v_up.valid? ).to eq(true)

        v_up = Vote.new(value: 1)
        expect( v_up.valid? ).to eq(true)

        v_down = Vote.new(value: -1)
        expect( v_down.valid? ).to eq(true)
     
        no_vote = Vote.new(value: 2)
        expect( no_vote.valid? ).to eq(false)
      end
    end
  end
end 

