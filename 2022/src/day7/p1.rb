class Node
  attr_accessor :name, :parent, :entries, :filesize

  def initialize(name, parent, filesize=nil)
    @name = name
    @parent = parent

    if filesize
      @filesize = filesize.to_i
    else
      @entries = {}
    end
  end

  def add_dir_entry(handle)
    return if @entries[handle]
    @entries[handle] = Node.new(handle, self)
  end

  def add_file_entry(filesize, handle)
    return if @entries[handle]
    @entries[handle] = Node.new(handle, self, filesize)
  end

  def size
    return @filesize if @filesize
    @entries.values.sum(&:size)
  end

  def directory?
    @filesize.nil?
  end
end

class ParseLog
  attr_accessor :current_node, :root_node, :log, :removable_nodes

  def initialize
    @root_node = Node.new('/', nil)
    @current_node = @root_node
    @log = File.read('shell_log.txt').split(/\n/)

    log.each do |line|
      parse_command(line[2..-1]) if line[0] == '$'
      parse_dir(line[4..-1]) if line[0..2] == 'dir'
      parse_file(*line.split) if line[0].match? /[0-9]/
    end
  end

  def parse_command(command_str)
    cmd, *args = command_str.split
    if cmd == 'cd'
      handle_cd(args.join(' '))
    end
  end

  def handle_cd(path)
    if path == '/'
      @current_node = root_node
    elsif path == '..'
      @current_node = @current_node.parent unless @current_node.parent.nil?
    else
      @current_node = @current_node.entries[path]
    end
  end

  def parse_dir(dir)
    @current_node.add_dir_entry(dir)
  end

  def parse_file(size, name)
    @current_node.add_file_entry(size, name)
  end

  def deletion_candidates
    @removable_nodes = []
    find_removable_nodes(@root_node)
    @removable_nodes
  end

  def find_removable_nodes(node)
    @removable_nodes << node.size if node.size <= 100_000

    node.entries.values.each do |node|
      find_removable_nodes(node) if node.directory?
    end
  end
end
p = ParseLog.new
p.deletion_candidates
