require 'set'

class FiniteAutomaton
  EPSILON = Object.new.tap do |o|
    def o.to_s
      "\xce\xb5"
    end
  end

  attr_accessor :start_state
  attr_accessor :current_state
  attr_accessor :transitions

  attr_reader :accept_states
  attr_reader :alphabet

  def initialize(start_state='s')
    @start_state = start_state
    @current_state = @start_state
    @transitions = Hash.new do |transitions, (state, character)|
      Set.new.tap do |empty_set|
        transitions[[state, character]] = empty_set
      end
    end
    @accept_states = Set.new
    @alphabet = Set.new
  end

  def add_transition(from, character, to)
    @alphabet << character
    @transitions[[from, character]] << to
  end

  def closure(character, *states)
    c = states.inject(Set.new) do |r, state|
      r | @transitions[[state, character]]
    end
    if character == EPSILON
      c | Set[*states]
    else
      # c unioned with the EPSILON-closure of each state in c
      c | closure(EPSILON, *c)
    end
  end

  def accept?(input)
    not (
      input.inject(closure(EPSILON, @start_state)) do |reachable, character|
        closure(character, *reachable)
      end & @accept_states
    ).empty?
  end
  alias_method :accepts?, :accept?

  def make_tranz(state, symbol)
    if not @transitions[[state, symbol]].nil? and (@transitions[[state, symbol]].any?)
      @current_state = @transitions[[state, symbol]].first
    else
      @current_state = -1
    end
    return @current_state
  end

  def final?(state)
    return @accept_states.include?(state)
  end

  #########################
  def merged_edges
    result = {}
    @transitions.inject([]) do
      |collected, ((source, character), targets)|
      collected + targets.map do |target|
        [source, character, target]
      end
    end.to_set.classify do |(source, character, target)|
      [source, target]
    end.each_pair do |(source, target), transitions|
      result[[source, target]] = transitions.map do |(_, character, _)|
        character
      end
    end
    result
  end
  private :merged_edges

  def to_dot
    require 'stringio'
    StringIO.new.tap do |output|
      output.puts 'digraph finite_automaton {'
      output.puts 'rankdir=LR;'
      output.puts 'size="8,5"'

      output.puts '0 [style=invis];'
      output.puts %Q/node [shape=doublecircle]; #{@accept_states.map {|t| %Q/"#{t}"/}.join(' ')};/
      output.puts 'node [shape=circle];'
      output.puts %Q/0 -> "#{start_state}";/
      merged_edges.each_pair do |(source, target), characters|
        output.puts %Q/"#{source}" -> "#{target}" [label="#{characters.join(', ')}"];/
      end

      output.puts '}'
    end.string
  end

  def to_graph_easy
    require 'stringio'
    StringIO.new.tap do |output|
      output.puts '[ 0 ] { shape: invisible; }'
      @accept_states.each do |state|
        output.puts "[ #{state} ] { border: double; }"
      end
      output.puts "[ 0 ] --> [ #{@start_state} ]"
      merged_edges.each_pair do |(source, target), characters|
        output.puts "[ #{source} ] -- #{characters.join(', ')} --> [ #{target} ]"
      end
    end.string
  end

  # display the automaton using graph-easy, maybe UNIX-centric
  def visualize
    require 'open3'
    Open3.popen3('graph-easy') do |i,o,_|
      i.write to_graph_easy
      i.close
      puts o.read
    end
  end

  # display the automaton by using dot and ImageMagick "display", UNIX-centric
  def x_visualize
    require 'open3'
    Open3.popen3('dot -T svg | display') do |i,o,_|
      i.write to_dot
      i.close
    end
  end
  ###########################


end

