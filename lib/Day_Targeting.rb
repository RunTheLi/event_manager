require 'csv'
require 'date'

# Read CSV file and extract registration timestamps
registration_times = []
CSV.open('event_attendees.csv', 'r', headers: true, header_converters: :symbol) do |csv|
  csv.each do |row|
    if row[:registration_date]
      registration_times << row[:registration_date]
    else
      puts "Missing registration date in row #{row}"
    end
  end
end

# Check if we have any registration times
if registration_times.empty?
  puts 'No registration times found in the CSV file.'
else
  puts "Found #{registration_times.length} registration times."
end

# Extract days of the week from timestamps
# wday returns an integer (0 = Sunday, 1 = Monday, ..., 6 = Saturday)
days = registration_times.map { |time| DateTime.parse(time).wday }

# Map wday values to day names (Sunday, Monday, ...)
days_names = {
  0 => 'Sunday',
  1 => 'Monday',
  2 => 'Tuesday',
  3 => 'Wednesday',
  4 => 'Thursday',
  5 => 'Friday',
  6 => 'Saturday'
}

# Count occurrences of each day
days_counts = days.each_with_object(Hash.new(0)) { |day, counts| counts[day] += 1 }

# If no days are counted, we can print a message
if days_counts.empty?
  puts 'No days counted. Check if the date parsing is correct.'
else
  # Sort by peak registration days in descending order
  sorted_days = days_counts.sort_by { |_day, count| -count }

  # Display peak registration days
  puts 'Peak Registration Days:'
  sorted_days.each do |day, count|
    puts "#{days_names[day]}: #{count} registrations"
  end
end
