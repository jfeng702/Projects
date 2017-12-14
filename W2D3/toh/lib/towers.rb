class Towers

  attr_reader :tower_content

  def initialize(tower_content)
    @tower_content = tower_content
  end

  def move(start_pos, end_pos)

    raise 'Invalid Move' if !valid?(start_pos, end_pos)

    @tower_content[end_pos] << @tower_content[start_pos].pop

    @tower_content
  end

  def valid?(start_pos, end_pos)
    if @tower_content[end_pos][-1].nil? || @tower_content[start_pos][-1] < @tower_content[end_pos][-1]
      return true
    else
      return false
    end
  end

  def won?

    @tower_content.count([3,2,1]) == 1

  end

  def play
    # puts @tower_content
    until won?
      puts "What's your starting move?"
      start = gets.chomp
      puts "What's your ending move?"
      ending = gets.chomp
      move(start.to_i, ending.to_i)
      print @tower_content
      p ""
    end
  end
end

initial = [[2], [1], [3]]
game = Towers.new(initial)
game.play
