require 'csv'

def clean_phone_num(homephone)
  digits = homephone.gsub(/\D/, '')
  if digits.length == 10
    digits
  elsif digits.length == 11 && digits.start_with?('1')
    digits[1..]
  else
    nil
  end
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

contents.each do |row|
  name = row[:first_name]

  homephone = row[:homephone]

  puts "#{name} #{homephone}"
end
