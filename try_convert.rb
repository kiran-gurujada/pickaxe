class ConfigFile
  def initialize(filename)
    @content = File.read(filename)
  end

  def to_hash
    result = {}
    @content.scan(/^(\w+):\s*(.*)/) do |name, value|
      result[name] = value
    end
    result
  end
end
config = ConfigFile.new("some_config")
p Hash.try_convert(config)
