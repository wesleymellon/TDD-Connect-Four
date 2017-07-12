require "spec_helper"

module ConnectFour
  describe Board do 

    describe "#initialize" do
      it "does not raise an error when presented with no arguments" do
        expect{ Board.new }.to_not raise_error
      end

      let(:board) { Board.new }
      it "initializes map to be empty" do
        expect(board.map).to eql([['_','_','_','_','_','_','_'], 
          ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'],
          ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'], 
          ['_','_','_','_','_','_','_']])
      end
    end

    describe "#add_piece" do
      let(:board) { Board.new }
      it "raises an error when presented with no arguments" do
        expect{ board.add_piece }.to raise_error(ArgumentError)
      end

      it "adds a single piece in the leftmost designated position" do
        board.add_piece('x', 0)
        expect(board.map).to eql([['x','_','_','_','_','_','_'], 
          ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'],
          ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'], 
          ['_','_','_','_','_','_','_']])
      end

      it "adds a single piece in the rightmost designated position" do
        board.add_piece('o', 6)
        expect(board.map).to eql([['_','_','_','_','_','_','o'], 
          ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'],
          ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'], 
          ['_','_','_','_','_','_','_']])
      end

      it "adds a single piece on top of another piece on the left" do 
        board.add_piece('x', 0)
        board.add_piece('x', 0)
        expect(board.map).to eql([['x','_','_','_','_','_','_'], 
          ['x','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'],
          ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'], 
          ['_','_','_','_','_','_','_']])
      end

      it "adds a single piece on top of another piece on the right" do
        board.add_piece('x', 6)
        board.add_piece('x', 6)
        expect(board.map).to eql([['_','_','_','_','_','_','x'], 
          ['_','_','_','_','_','_','x'], ['_','_','_','_','_','_','_'],
          ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'], 
          ['_','_','_','_','_','_','_']])
      end

      it "adds pieces on the same row with pre-existing pieces" do
        board.map = [['x','x','o','o','x','_','o'], 
          ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'],
          ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'], 
          ['_','_','_','_','_','_','_']]
        board.add_piece('x', 5)
        expect(board.map).to eql([['x','x','o','o','x','x','o'], 
          ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'],
          ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'], 
          ['_','_','_','_','_','_','_']])
      end

      it "adds pieces on top of other rows that is already full of pieces" do
        board.map = [['x','x','o','o','x','o','o'], 
          ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'],
          ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'], 
          ['_','_','_','_','_','_','_']]
        board.add_piece('x',1)
        expect(board.map).to eql([['x','x','o','o','x','o','o'], 
          ['_','x','_','_','_','_','_'], ['_','_','_','_','_','_','_'],
          ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'], 
          ['_','_','_','_','_','_','_']])
      end
    end

    describe "#game_end_vert?" do
      let(:board) {Board.new}

      it "returns false if the board is empty" do
        expect(board.game_end_vert?()).to eql(false)
      end

      it "returns false if the four horizontal pieces are of different type" do
        board.map = [['x','_','_','_','_','_','_'], 
          ['o','_','_','_','_','_','_'], ['x','_','_','_','_','_','_'],
          ['x','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'], 
          ['_','_','_','_','_','_','_']]
        expect(board.game_end_vert?()).to eql(false)
      end

      it "returns true if the leftmost bottom four pieces are 'x'" do
        board.map = [['x','_','_','_','_','_','_'], 
          ['x','_','_','_','_','_','_'], ['x','_','_','_','_','_','_'],
          ['x','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'], 
          ['_','_','_','_','_','_','_']]
        expect(board.game_end_vert?()).to eql(true)
      end

      it "returns true if the second leftmost top four pieces are 'o'" do
        board.map = [['_','_','_','_','_','_','_'], 
          ['_','_','_','_','_','_','_'], ['_','o','_','_','_','_','_'],
          ['_','o','_','_','_','_','_'], ['_','o','_','_','_','_','_'], 
          ['_','o','_','_','_','_','_']]
        expect(board.game_end_vert?()).to eql(true)
      end

      it "returns false if the leftmost row is a mix of 'x' and 'o's" do
        board.map = [['x','_','_','_','_','_','_'], 
          ['o','_','_','_','_','_','_'], ['x','_','_','_','_','_','_'],
          ['x','_','_','_','_','_','_'], ['x','_','_','_','_','_','_'], 
          ['o','_','_','_','_','_','_']]
        expect(board.game_end_vert?()).to eql(false)
      end

      it "returns true if there are multiple columns, only one of which" \
        "has four in a row" do
        board.map = [['o','o','o','x','_','_','_'], 
          ['x','x','o','x','_','_','_'], ['x','x','o','o','_','_','_'],
          ['x','o','o','o','_','_','_'], ['o','o','o','x','_','_','_'], 
          ['o','x','x','o','_','_','_']]
        expect(board.game_end_vert?()).to eql(true)
      end

      it "returns false if there are only three in a row" do
        board.map = [['x','_','_','_','_','_','_'], 
          ['x','_','_','_','_','_','_'], ['x','_','_','_','_','_','_'],
          ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'], 
          ['_','_','_','_','_','_','_']]
        expect(board.game_end_vert?()).to eql(false)
      end
    end

    describe "#game_end_horz?" do
      let(:board) {Board.new}

      it "returns false if the board is empty" do
        expect(board.game_end_horz?()).to eql(false)
      end

      it "returns true if the bottom left four pieces are 'x'" do
        board.map = [['x','x','x','x','_','_','_'], 
          ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'],
          ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'], 
          ['_','_','_','_','_','_','_']]
        expect(board.game_end_horz?()).to eql(true)
      end

      it "returns false if the bottom left pieces are mixed" do
        board.map = [['x','o','o','x','_','_','_'], 
          ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'],
          ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'], 
          ['_','_','_','_','_','_','_']]
        expect(board.game_end_horz?()).to eql(false)
      end

      it "returns true if the top most right pieces are 'o's" do
        board.map = [['_','_','_','_','_','_','_'], 
          ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'],
          ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'], 
          ['_','_','_','o','o','o','o']]
        expect(board.game_end_horz?()).to eql(true)
      end

      it "returns false if there are only three in a row" do
        board.map = [['_','x','x','x','_','_','_'], 
          ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'],
          ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','_'], 
          ['_','_','_','_','_','_','_']]
        expect(board.game_end_horz?()).to eql(false)
      end

      it "returns true if there are multiple filled rows and one with" \
        "four 'o's in a row" do
        board.map = [['o','x','o','x','_','_','_'], 
          ['x','x','x','o','_','_','_'], ['x','o','o','o','_','_','_'],
          ['o','o','o','o','_','_','_'], ['_','_','_','_','_','_','_'], 
          ['_','_','_','_','_','_','_']]
        expect(board.game_end_horz?()).to eql(true)
      end
    end

    describe "#game_end_diag?" do
      let(:board) {Board.new}

      it "returns false if the board is empty" do
        expect(board.game_end_diag?()).to eql(false)
      end

      it "returns true if the top left forward diag line are 'x's" do
        board.map = [['_','_','_','_','_','_','_'], 
          ['_','_','_','_','_','_','_'], ['x','_','_','_','_','_','_'],
          ['_','x','_','_','_','_','_'], ['_','_','x','_','_','_','_'], 
          ['_','_','_','x','_','_','_']]
        expect(board.game_end_diag?()).to eql(true)
      end

      it "returns true if the top right backward diag line are 'o's" do
        board.map = [['_','_','_','_','_','_','_'], 
          ['_','_','_','_','_','_','_'], ['_','_','_','_','_','_','o'],
          ['_','_','_','_','_','o','_'], ['_','_','_','_','o','_','_'], 
          ['_','_','_','o','_','_','_']]
        expect(board.game_end_diag?()).to eql(true)
      end

      it "returns true if the middle forward diag line are 'x's" do
        board.map = [['_','o','_','_','_','_','_'], 
          ['_','x','_','_','_','_','_'], ['_','_','x','_','_','_','_'],
          ['_','_','_','x','_','_','_'], ['_','_','_','_','x','_','_'], 
          ['_','_','_','_','_','o','_']]
        expect(board.game_end_diag?()).to eql(true)
      end

      it "returns false if the forward diag line is mixed" do 
        board.map = [['x','_','_','_','_','_','_'], 
          ['_','x','_','_','_','_','_'], ['_','_','o','_','_','_','_'],
          ['_','_','_','x','_','_','_'], ['_','_','_','_','o','_','_'], 
          ['_','_','_','_','_','o','_']]
        expect(board.game_end_diag?()).to eql(false)
      end
    end

  end
end