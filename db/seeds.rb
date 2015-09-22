500.times do
  phones = []
  rand(1..4).times { phones << Faker::PhoneNumber.cell_phone }

  emails = []
  rand(1..4).times { emails << Faker::Internet.email }

  contact = Contact.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phones: phones,
    emails: emails
  )
end