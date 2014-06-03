require 'builder'

xml = Builder::XmlMarkup.new(target: STDOUT, indent: 2)
xml.person(type: 'programmer') do
  xml.name do
    xml.first 'Sam'
  end
  xml.location "Chile"
  xml.preference "ruby"
end
