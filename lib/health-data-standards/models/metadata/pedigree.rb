module Metadata
  class Pedigree
    include Mongoid::Document

    field :author, type: String
    field :organization, type: String

    def to_xml(options)
      require 'builder'
      xml = options[:builder] || ::Nokogiri::XML::Builder.new
      hmd = options[:ns_prefix]
      xml[hmd].PedigreeInfo do
        xml[hmd].Author self.author if self[:author]
        xml[hmd].Organization self.organization if self.organization
      end
    end

    def from_xml(node, options)
      require 'builder'
      hmd = options[:ns_prefix]
      a = node.at_xpath("./#{hmd}:Author")
      o = node.at_xpath("./#{hmd}:Organization")
      self.author = a.text() if a
      self.organization = o.text() if o
    end
  end
end