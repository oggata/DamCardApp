#gem install parse-ruby-client
require 'parse-ruby-client'
#require_relative 'parse_keys.rb'
Parse.init :application_id => "dBzkl9gkGPsQoyRHq5WOv9wzbUmK9QEhJXBpO6mf",
           :api_key        => "oP67U8lHvKap1wKKXNajE4T2vPENtWQ7klx43laO"

Encoding.default_external = 'UTF-8'
File.open("dams.tsv","r") do |file|
  file.each do |row|
    #print "\n"
  	columns = row.split("\t")
	dams = Parse::Object.new('Dams')
	#xlsManageId = data[0]
	#print xlsManageId
	dams[:xlsManageId] = 1
	dams[:name] = columns[1]
	dams[:versionNumber] = 1
	dams[:distributionPlaceName] = columns[3]
	dams[:distributionDate] = columns[4]
	dams[:prefectureName] = columns[5]
	dams[:address] = columns[6]
	dams[:url] = columns[7]
	dams.save
  end
end


