#gem install parse-ruby-client
require 'parse-ruby-client'
#require_relative 'parse_keys.rb'
Parse.init :application_id => "dBzkl9gkGPsQoyRHq5WOv9wzbUmK9QEhJXBpO6mf",
           :api_key        => "oP67U8lHvKap1wKKXNajE4T2vPENtWQ7klx43laO"

Encoding.default_external = 'UTF-8'

#Delete ALL Rows
dams_all_cnt = Parse::Query.new("Dams").get.length
for num in 1..dams_all_cnt do
	del_target = Parse::Query.new("Dams").get.first
	del_target.parse_delete
end

#Create Row From TSV File
File.open("dams.tsv","r") do |file|
  file.each_line do |row|
  	columns = row.split("\t")
	dams = Parse::Object.new('Dams')
	#print columns[1]
	#print "\n"
	dams[:xlsManageId] = columns[0].to_i
	dams[:name] = columns[1]
	dams[:versionNumber] = 1
	dams[:distributionPlaceName] = columns[3]
	dams[:distributionDate] = columns[4]
	dams[:prefectureName] = columns[5]
	dams[:address] = columns[6]
	dams[:url] = columns[7]
	dams[:isOpenWeekEnd] = columns[8].to_i
	dams.save
  end
end

