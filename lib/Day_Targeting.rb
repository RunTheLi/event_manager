require 'csv'
require 'date'

# Read CSV file and extract registration timestamps
registration_times = []
CSV.foreach('event_attendees.csv', headers: true, header_converters: :symbol) do |row|
  registration_times << row[:registration_date] if row[:registration_date]
end

# Extract hours from timestamps
days = registration_times.map { |time| DateTime.parse(time).wday }

# Count occurrences of each hour
days_counts = days.tally

# Sort by peak hours in descending order
sorted_days = days_counts.sort_by { |_day, count| -count }

# Display peak hours
puts 'Peak Registration Hours:'
sorted_days.each { |day, count| puts "Hour #{days[day]}: #{count} registrations" }
