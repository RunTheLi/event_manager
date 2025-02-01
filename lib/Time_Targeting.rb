require 'csv'
require 'date'

# Read CSV file and extract registration timestamps
registration_times = []
CSV.foreach('event_attendees.csv', headers: true, header_converters: :symbol) do |row|
  registration_times << row[:registration_date] if row[:registration_date]
end

# Extract hours from timestamps
hours = registration_times.map { |time| DateTime.parse(time).hour }

# Count occurrences of each hour
hourly_counts = hours.tally

# Sort by peak hours in descending order
sorted_hours = hourly_counts.sort_by { |_hour, count| count }.reverse

# Display peak hours
puts 'Peak Registration Hours:'
sorted_hours.each { |hour, count| puts "Hour #{hour}: #{count} registrations" }
