require "spec_helper"

module ConnectFour
  describe Player do

    describe "#initialize" do
      it "raises error when initialized without arguments" do
        expect{ Player.new }.to raise_error(ArgumentError)
      end

      it "does not raise error when initialized with name and color" do
        expect{ Player.new("Bob", "Blue") }.to_not raise_error
      end 
    end

    let(:player) { Player.new("Bob", "Red") }

    describe "#name" do
      it "returns the name of the player" do
        expect(player.name).to eql("Bob")
      end

      it "returns the color of the player" do
        expect(player.color).to eql("Red")
      end

    end
  end
end