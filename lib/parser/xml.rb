require 'faster_xml_simple'

module Parser
  class Xml
    def self.parse(file, opts = {})
      return ArgumentError if file.empty? || opts[:node].empty?
      doc = FasterXmlSimple.xml_in(file)
      doc[opts[:node]]
    end
  end
end