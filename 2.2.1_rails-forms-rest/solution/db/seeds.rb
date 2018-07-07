# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
c1 = Cohort.create(name: 'web-103017')
c2 = Cohort.create(name: 'web-112017')

s1 = Student.create(name: 'Rachel')
s2 = Student.create(name: 'Lindsey')
s3 = Student.create(name: 'Esmery')
s4 = Student.create(name: 'Alex')
s5 = Student.create(name: 'Johann')
s6 = Student.create(name: 'Meryl')
