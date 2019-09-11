Reminder.destroy_all
Strike.destroy_all
User.destroy_all
Union.destroy_all
Category.destroy_all
Sector.destroy_all

puts 'Started Seeding'
User.create!(
  email: "user@gmail.com",
  password: "123456",
  admin: false
)

User.create(email: "pacmanreis@gmail.com",
  password: "123456",
  admin: true
  )

User.create(email: "bokac279@gmail.com",
  password: "123456",
  admin: true
  )

User.create(email: "fgaspar9@icloud.com",
  password: "123456",
  admin: true
  )

puts ''
Sector.create(name: 'Transportation')
Sector.create(name: 'Health')
Sector.create(name: 'Education')
Sector.create(name: 'Finances')
Sector.create(name: 'Records')
Sector.create(name: 'Justice')
Sector.create(name: 'General')
Sector.create(name: 'Other')
Sector.create(name: 'Administration')
Sector.create(name: 'Central Administration')
Sector.create(name: 'Agricultural')
Sector.create(name: 'Local Administration')

# 1..17
Category.create(name: 'Train', sector_id: 1)
Category.create(name: 'Subway', sector_id: 1)
Category.create(name: 'Ship', sector_id: 1)
Category.create(name: 'Taxi', sector_id: 1)
Category.create(name: 'Plane', sector_id: 1)
Category.create(name: 'Bus', sector_id: 1)
Category.create(name: 'Health', sector_id: 2)
Category.create(name: 'Education', sector_id: 3)
Category.create(name: 'Finances', sector_id: 4)
Category.create(name: 'Records', sector_id: 5)
Category.create(name: 'Justice', sector_id: 6)
Category.create(name: 'General', sector_id: 7)
Category.create(name: 'Other', sector_id: 8)
Category.create(name: 'Administration', sector_id: 9)
Category.create(name: 'Central Administration', sector_id: 10)
Category.create(name: 'Agricultural', sector_id: 11)
Category.create(name: 'Local Administration', sector_id: 12)

# 18..19
Category.create(name: 'Doctors', sector_id: 2)
Category.create(name: 'Nurses', sector_id: 2)

# 19..20
Category.create(name: 'Teachers', sector_id: 3)
Category.create(name: 'School helpers', sector_id: 3)

# 21..
Category.create(name: 'Registry clerk', sector_id: 4)

# 22..23
Category.create(name: 'Judges', sector_id: 5)
Category.create(name: 'Justice clerks', sector_id: 5)

# 1..11

# Real Strikes

Strike.create(organization: 'Ryanair',
              start_date: '2019-09-18',
              end_date: '2019-09-18',
              category_id: 5)

Strike.create(organization: 'Ryanair',
              start_date: '2019-09-19',
              end_date: '2019-09-19',
              category_id: 5)

Strike.create(organization: 'Ryanair',
              start_date: '2019-09-21',
              end_date: '2019-09-21',
              category_id: 5)

Strike.create(organization: 'Ryanair',
              start_date: '2019-09-23',
              end_date: '2019-09-23',
              category_id: 5)

Strike.create(organization: 'Ryanair',
              start_date: '2019-09-25',
              end_date: '2019-09-25',
              category_id: 5)

Strike.create(organization: 'Ryanair',
              start_date: '2019-09-27',
              end_date: '2019-09-27',
              category_id: 5)

Strike.create(organization: 'Ryanair',
              start_date: '2019-09-29',
              end_date: '2019-09-29',
              category_id: 5)


Strike.create(organization: 'Ryanair',
              start_date: '2019-08-20',
              end_date: '2019-08-25',
              category_id: 5)

Strike.create(organization: 'Ryanair',
              start_date: '2019-09-27',
              end_date: '2019-08-27',
              category_id: 5)

Strike.create(organization: 'British Airways',
              description: 'Para exigir melhorias salariais.',
              start_date: '2019-09-09',
              end_date: '2019-09-09',
              category_id: 5)

Strike.create(organization: 'British Airways',
              description: 'Para exigir melhorias salariais.',
              start_date: '2019-09-10',
              end_date: '2019-09-10',
              category_id: 5)

Strike.create(organization: 'British Airways',
              description: 'Para exigir melhorias salariais.',
              start_date: '2019-09-27',
              end_date: '2019-09-27',
              category_id: 5)

Strike.create(organization: 'Registos',
              description: 'Em defesa de remunerações, promoções e abertura de concursos.',
              start_date: '2019-09-09',
              end_date: '2019-09-09',
              category_id: 10)

Strike.create(organization: 'Registos',
              description: 'Em defesa de remunerações, promoções e abertura de concursos.',
              start_date: '2019-09-17',
              end_date: '2019-09-17',
              category_id: 10)

Strike.create(organization: 'Registos',
              description: 'Em defesa de remunerações, promoções e abertura de concursos.',
              start_date: '2019-09-24',
              end_date: '2019-09-24',
              category_id: 10)


Strike.create(organization: 'Trabalhadores da Tapada Nacional de Mafra ',
              description: 'Contra a falta de condições de trabalho.',
              start_date: '2019-09-11',
              end_date: '2019-09-11',
              category_id: 17)

# Put Fake Strikes Below if you want to do tests

puts 'Done!'

# Scraping below

puts 'Started Scraping'

require 'open-uri'
require 'nokogiri'
require 'pry-byebug'
require 'csv'

url = "https://www.dgaep.gov.pt/index.cfm?&OBJID=32B5C008-D957-4C3E-B00A-2ECE2208212A&ComDest=0&Tab=4"

html_file = open(url).read
html_doc = Nokogiri::HTML(html_file)

public_strikes = []

html_doc.search('tr td').each do |element|
  public_strikes << element.text.strip
end

csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
filepath    = 'public_strikes.csv'

pstrikes = public_strikes.each_slice(5).to_a

pstrikes.each do |strike|
  cat = 13

  if strike[4] == "Finanças"
    cat = 9
    elsif strike[4] == "Justiça"
      cat = 11
    elsif strike[4] == "Saúde"
      cat = 7
    elsif strike[4] == "Educação"
      cat = 8
    elsif strike[4] == "Todas"
      cat = 12
    elsif strike[4] == "Outra"
      cat = 13
    elsif strike[4] == "Administração"
      cat = 15
    elsif strike[4] == "Administração Central"
      cat = 15
    elsif strike[4] == "Agricultura"
      cat = 16
    elsif strike[4] == "Administração Local"
      cat = 17
  end

  Strike.create(organization: strike[3].gsub("Setorial - ", '').gsub("Setorial ", '').gsub("(", '').gsub(")", ''),
                description: "Sindicatos - #{strike[0]}",
                start_date: strike[2],
                end_date: strike[2],
                category_id: cat)
end

puts 'Done'
