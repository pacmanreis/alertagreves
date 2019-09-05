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
Sector.create(name: 'Public')

# 1..6
Category.create(name: 'Train', sector_id: 1)
Category.create(name: 'Subway', sector_id: 1)
Category.create(name: 'Ship', sector_id: 1)
Category.create(name: 'Taxi', sector_id: 1)
Category.create(name: 'Plane', sector_id: 1)
Category.create(name: 'Bus', sector_id: 1)

# 7
Category.create(name: 'Records', sector_id: 2)

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
