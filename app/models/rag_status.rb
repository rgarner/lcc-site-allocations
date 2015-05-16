class RAGStatus
  attr_accessor :abbr, :color, :description
  def initialize(abbr, color, description = nil)
    self.abbr = abbr
    self.color = color
    self.description = description
  end

  def self.all
    @_all ||= [
      RAGStatus.new('G', 'Green', nil),
      RAGStatus.new('A', 'Amber', nil),
      RAGStatus.new('R', 'Red', nil),
      RAGStatus.new('LG', 'Lime green', 'identified'),
      RAGStatus.new('P', 'Purple', 'sieved out'),
      RAGStatus.new('NonIO', nil, 'Site not in issues and options'),
      RAGStatus.new('AV', nil, 'Aire Valley'),
    ]
  end

  def self.[](abbr)
    @_by_abbr ||= RAGStatus.all.inject({}) do |hash, status|
      hash[status.abbr] = status
      hash
    end

    @_by_abbr[abbr]
  end

  def display_name
    "#{color || abbr}#{ description ? " (#{description})" : ''}"
  end
end
