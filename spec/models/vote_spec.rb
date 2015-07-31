require 'rails_helper'
include TestFactories

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

  describe 'after_save' do
    it "calls `Post#update_rank` after save" do
      post = associated_post
      vote = Vote.new(value: 1, post: post)
      expect(post).to receive(:update_rank)
      vote.save
    end
  end
end 


