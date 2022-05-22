puts 'Seeding data......'
5.times do |t|
  t = t + 1
  User.create!(email: "test#{t}@test.test", password: '123456')
end
puts 'Seeding completed......'
