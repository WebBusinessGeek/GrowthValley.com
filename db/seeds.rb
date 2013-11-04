# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

## Create Subjects:
Subject.create!(name: 'Accounting')
Subject.create!(name: 'Finance')
Subject.create!(name: 'Admin')
Subject.create!(name: 'Office')
Subject.create!(name: 'Advertising')
Subject.create!(name: 'Architechture')
Subject.create!(name: 'Engineering')
Subject.create!(name: 'Art')
Subject.create!(name: 'Media')
Subject.create!(name: 'Design')
Subject.create!(name: 'Science')
Subject.create!(name: 'Business Development')
Subject.create!(name: 'Business')
Subject.create!(name: 'Management')
Subject.create!(name: 'Computer Programming')
Subject.create!(name: 'Customer Service')
Subject.create!(name: 'Education')
Subject.create!(name: 'ETC')
Subject.create!(name: 'Fitness')
Subject.create!(name: 'Freelance Skills')
Subject.create!(name: 'General Labour')
Subject.create!(name: 'Government')
Subject.create!(name: 'Hospitality')
Subject.create!(name: 'Human Resources')
Subject.create!(name: 'Internet Engineering')
Subject.create!(name: 'Legal')
Subject.create!(name: 'Paralegal')
Subject.create!(name: 'Manufacturing')
Subject.create!(name: 'Marketing')
Subject.create!(name: 'Internet Marketing')
Subject.create!(name: 'Medical')
Subject.create!(name: 'Health')
Subject.create!(name: 'Non-Profits')
Subject.create!(name: 'Public Relations')
Subject.create!(name: 'Real Estate')
Subject.create!(name: 'Retail')
Subject.create!(name: 'Sales')
Subject.create!(name: 'Salon')
Subject.create!(name: 'Spa')
Subject.create!(name: 'Security')
Subject.create!(name: 'Skilled Trade')
Subject.create!(name: 'Software Development')
Subject.create!(name: 'Tech Support')
Subject.create!(name: 'Film')
Subject.create!(name: 'Media')
Subject.create!(name: 'Web Design')
Subject.create!(name: 'Writing/Editing')

## Create Teacher:
teacher = Teacher.new(full_name: 'First Teacher', email: 'teacher@idify.in', password: '12345678')
teacher.confirmed_at = '2013-11-01 10:55:39 +0000'
teacher.save!

## Create Learner:
learner = Learner.new(full_name: 'First Learner', email: 'learner@idify.in', password: '12345678')
learner.confirmed_at = '2013-11-01 10:55:39 +0000'
learner.save!
