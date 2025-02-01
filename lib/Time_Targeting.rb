require 'csv'
require 'date'

# Read CSV file and extract registration timestamps
registration_times = []
CSV.foreach('event_attendees.csv', headers: true, header_converters: :symbol) do |row|
  if row[:registration_date]
    begin
      # Parse the registration date and store the timestamp
      registration_times << DateTime.parse(row[:registration_date])
    rescue ArgumentError => e
      puts "Skipping invalid date: #{row[:registration_date]} (Error: #{e.message})"
    end
  end
end

# Check if we have any registration times
if registration_times.empty?
  puts 'No valid registration dates found.'
else
  # Extract hours from timestamps
  hours = registration_times.map { |time| time.hour }

  # Count occurrences of each hour
  hourly_counts = hours.tally

  # Sort by peak hours in descending order
  sorted_hours = hourly_counts.sort_by { |_hour, count| -count }

  # Display peak hours
  puts 'Peak Registration Hours:'
  sorted_hours.each do |hour, count|
    puts "Hour #{hour}: #{count} registrations"
  end
end
