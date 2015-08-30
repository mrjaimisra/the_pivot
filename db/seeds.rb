class Seed
  def self.start
    seed = Seed.new
    seed.generate_roles
    seed.generate_customers
    seed.generate_photographers
    seed.generate_platform_admins
    seed.generate_categories
    seed.generate_photos
    seed.generate_stores
    seed.generate_orders
  end

  def generate_roles
    Role.create!(name: "registered_user")
    Role.create!(name: "store_admin")
    Role.create!(name: "platform_admin")
  end

  def generate_customers
    user = User.create(name: "Josh",
                       email: "josh@turing.io",
                       password: "password",
    )

    # users.each do |name, email, password, avatar, header|
    #   User.create(name: name,
                    # email: email,
                    # password: password,
                    # avatar = File.open("/app/assets/images/avatars/#{avatar}.jpg")
                    # header = File.open("/app/assets/images/headers/#{header}.jpg")
    # end

    99.times do |i|
      customer = User.create!(
          name: Faker::Name.name,
          email: Faker::Internet.email,
          password: Faker::Internet.password,
      )

      puts "Customer #{i}: #{customer.name} - #{customer.email} - #{customer.password} created!"
    end
  end

  def generate_photographers
    store_admin_role =  Role.find_by(name: "store_admin")
    admin = User.create!(
        name: "Carmer",
        email: "andrew@turing.io",
        password: "password",
    )
    admin.roles << store_admin_role

    # stores.each do |name, email, avatar, header|
    #   User.create(name: name,
                    # email: email,
                    # avatar = File.open("/app/assets/images/avatars/#{avatar}.jpg")
                    # header = File.open("/app/assets/images/headers/#{header}.jpg")
    # end

    19.times do |i|
      photographer = User.create!(
          name: Faker::Name.name,
          email: Faker::Internet.email,
          password: Faker::Internet.password
      )
      photographer.roles << store_admin_role
      puts "Photographer #{i}: #{photographer.name} - #{photographer.email} - #{photographer.password} created!"
    end
  end

  def generate_platform_admins
    site_admin_role = Role.find_by(name: "platform_admin")
    platform_admin = User.create!(
        name: "Jorge",
        email: "jorge@turing.io",
        password: "password",
    )
    platform_admin.roles << site_admin_role

    puts "Platform Admin #{platform_admin.name} - #{platform_admin.email} - #{platform_admin.password} created!"
  end

  def generate_categories
    categories = ["Travel", "Plants", "Leisure", "People", "Patterns",
    "Animals", "Architecture", "Sports", "Weddings",
    "Landscape"]
    10.times do |i|
      name = categories.pop
      category = Category.create!(
      name: name
      )
      puts "Category #{i}: #{category.name} created!"
    end
  end

  def generate_photos
    50.times do |i|
      10.times do |j|
        photo = Photo.create!(
        name: Faker::Commerce.product_name,
        description: Faker::Lorem.paragraph,
        price: Faker::Commerce.price + 1,
        category_id: j+1,
        image_url: "http://robohash.org/#{i}.png?set=set2&bgset=bg1&size=200x200"
        )
        puts "Photo #{i * 10 + j}: #{photo.name} created!"
      end
    end
  end

  def generate_stores
    Store.create!(name: "MKPhotography")

    19.times do |i|
      store = Store.create!(
        name: Faker::Company.name
      )
      add_photos(store)
      puts "Store #{i}: #{store.name} created!"
    end

  end

  # def generate_business_admins
  #     business_admin = User.create!(
  #         name: Faker::Name.name,
  #         email: andrew@turing.io,
  #         role: 1,
  #         password: "password",
  #     )
  #
  #     puts "Business Admin #{i}: #{business_admin.name} - #{business_admin.email} - #{business_admin.password} created!"
  # end

  def generate_orders
    10.times do |i|
      customers = User.registered_users
      customers.each do |customer|
        order = Order.create!(user_id: customer.id)
        add_photos(order)
        puts "Order #{i}: Order for #{customer.name} created!"
      end
    end
  end

  private

  def add_photos(order)
    10.times do |i|
      photo = Photo.find(Random.new.rand(1..500))
      order.photos << photo
      puts "#{i}: Added photo #{photo.name} to order #{photo.id}."
    end
  end

  # def users
  # [
  #   ["Jeff Casimir",    "jeff@turing.io",   "password", jeff],
  #   ["Jorge Tellez",    "jorge@turing.io",  "password", jorge],
  #   ["Josh Cheek",      "joshc@turing.io",  "password", joshc],
  #   ["Josh Mejia",      "joshm@turing.io",  "password", joshm],
  #   ["Horace Williams", "horace@turing.io", "password", horace],
  #   ["Steve Kinney",    "steve@turing.io",  "password", steve],
  #   ["Rachel Warbelow", "rachel@turing.io", "password", rachel]
  # ]
  # end

  # def stores
  # [
  #   ["Linda Snyder",    "linda@snyder.com",      "#", "#"],
  #   ["Danielle Austin", "hello@daphoto.com",     "#", "#"],
  #   ["Ann Johnson",     "annj@johnsonphoto.com", "#", "#"]
  # ]
  # end

end

Seed.start
