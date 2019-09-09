Reminder.destroy_all
Strike.destroy_all
User.destroy_all
Union.destroy_all
Category.destroy_all
Sector.destroy_all

puts 'Started Seeding'
User.create!(
  email: "test@gmail.com",
  password: 123_456,
  admin: false
)

User.create(email: "admin@gmail.com",
  password: "testadmin",
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

# 1..6
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

# 7..8
Category.create(name: 'Doctors', sector_id: 2)
Category.create(name: 'Nurses', sector_id: 2)

# 9..10
Category.create(name: 'Teachers', sector_id: 3)
Category.create(name: 'School helpers', sector_id: 3)

# 11..
Category.create(name: 'Registry clerk', sector_id: 4)

# 12..
Category.create(name: 'Judges', sector_id: 5)
Category.create(name: 'Justice clerks', sector_id: 5)

Union.create(name: 'British Airline Pilots Association',
             initials: 'BALPA',
             url: 'https://www.balpa.org/')

Union.create(name: 'Sindicato Nacional dos Registos',
             initials: 'SNR',
             url: 'https://www.facebook.com/SindicatoNacionaldosRegistos/')

# 1..11
Strike.create(organization: 'Ryanair',
              description: 'Os pilotos da Ryanair no Reino Unido estão em protesto contra as condições laborais e salariais praticadas pela companhia.',
              start_date: '2019-09-02',
              end_date: '2019-09-02',
              union_id: 1,
              category_id: 5)

Strike.create(organization: 'CP',
              description: 'Para exigir melhorias salariais.',
              start_date: '2019-09-27 00:00:00',
              end_date: '2019-09-27 23:59:59',
              union_id: 1,
              category_id: 1)

Strike.create(organization: 'Ryanair',
              description: 'Os pilotos da Ryanair no Reino Unido estão em protesto contra as condições laborais e salariais praticadas pela companhia.',
              start_date: '2019-09-03',
              end_date: '2019-09-03',
              union_id: 1,
              category_id: 5)

Strike.create(organization: 'Ryanair',
              description: 'Os pilotos da Ryanair no Reino Unido estão em protesto contra as condições laborais e salariais praticadas pela companhia.',
              start_date: '2019-09-04',
              end_date: '2019-09-04',
              union_id: 1,
              category_id: 5)

Strike.create(organization: 'Expressos',
              description: 'Para exigir melhorias salariais.',
              start_date: '2019-09-27 00:00:00',
              end_date: '2019-09-27 23:59:59',
              union_id: 1,
              category_id: 6)

Strike.create(organization: 'British Airways',
              description: 'Para exigir melhorias salariais.',
              start_date: '2019-09-09',
              end_date: '2019-09-09',
              union_id: 1,
              category_id: 5)

Strike.create(organization: 'Uber',
              description: 'Para exigir melhorias salariais.',
              start_date: '2019-09-10',
              end_date: '2019-09-10',
              union_id: 1,
              category_id: 4)


Strike.create(organization: 'British Airways',
              description: 'Para exigir melhorias salariais.',
              start_date: '2019-09-27',
              end_date: '2019-09-27',
              union_id: 1,
              category_id: 5)


Strike.create(organization: 'TAP',
              description: 'Para exigir melhorias salariais.',
              start_date: '2019-09-09',
              end_date: '2019-09-09',
              union_id: 1,
              category_id: 5)


Strike.create(organization: 'Metro',
              description: 'Defende um sistema remuneratório, progressão e promoções na carreira e abertura de novos concursos internos e externos.',
              start_date: '2019-09-16',
              end_date: '2019-09-16',
              union_id: 1,
              category_id: 2)

Strike.create(organization: 'Shipping PT',
              description: 'Defende um sistema remuneratório, progressão e promoções na carreira e abertura de novos concursos internos e externos.',
              start_date: '2019-09-23',
              end_date: '2019-09-23',
              union_id: 1,
              category_id: 3)



Strike.create(organization: 'Expressos',
              description: 'Defende um sistema remuneratório, progressão e promoções na carreira e abertura de novos concursos internos e externos.',
              start_date: '2019-09-30',
              end_date: '2019-09-30',
              union_id: 1,
              category_id: 6)



puts 'Done!'

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
                union_id: 1,
                category_id: cat)
end

puts 'Done'
