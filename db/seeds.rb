# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(username: "superadmin", name: "Superadmin", password: "tes123", email: "superadmin@gmail.com")

uom1 = Uom.create(code: "Pcs", name: "Pcs", state: true)
uom2 = Uom.create(code: "Unit", name: "Unit", state: true)

Item.create(sku: "000001", name: "Sofa", uom_id: uom2.id, state: true)
Item.create(sku: "000002", name: "TV", uom_id: uom2.id, state: true)

Tax.create(percentage: 11, year: 2024, state: true)

Payment.create(code: "Cash", name: "Cash", state: true)
Payment.create(code: "Debit", name: "Debit", state: true)
Payment.create(code: "Kredit", name: "Kredit", state: true)

