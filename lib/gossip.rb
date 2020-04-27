#require 'pry'
require 'csv'

class Gossip
	attr_accessor :author, :content

	def initialize(author, content)
		@content = content
		@author = author
	end

	def save
		CSV.open("./db/gossip.csv", "a+", {force_quotes: true}) do |csv|
  		csv << ["#{@author}","#{@content}"]
  		end
	end

	def self.all
		all_gossips = []
		CSV.read("./db/gossip.csv").each do |csv_line|
			all_gossips << Gossip.new(csv_line[0], csv_line[1])
		end
		return all_gossips
	end

  	def self.find(id)
    	csv_line = CSV.read("./db/gossip.csv")[id.to_i - 1]
    	return [Gossip.new(csv_line[0], csv_line[1])]
  	end

 	def update(id)
    	my_csv = CSV.read("./db/gossip.csv")
    	my_csv[id.to_i - 1] = [@author, @content]
    	CSV.open('./db/gossip.csv', 'wb') do |csv| 
    	  my_csv.each {|gossip| csv << gossip } 
    	end
 	 end
end

