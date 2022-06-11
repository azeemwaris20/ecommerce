# seeding data
# frozen_string_literal: true

user = User.new(email: 'azeemwaris125@gmail.com',
                username: 'Azeem Waris',
                address: '123 kdeff fdf',
                mobile: '03456789012')
user.password = '123456'
user.password_confirmation = '123456'
user.skip_confirmation!
user.avatar.attach(io: File.open('app/assets/images/profile/azeemwaris.jpg'),
                   filename: 'azeemwaris.jpg', content_type: 'image/jpeg')
user.save!

user = User.new(email: 'azeem.waris@devsinc.com',
                username: 'Azeem Waris2',
                address: '123 kdeff fdf',
                mobile: '03416789012')
user.password = '123456'
user.password_confirmation = '123456'
user.skip_confirmation!
user.avatar.attach(io: File.open('app/assets/images/profile/azeemwaris2.jpg'),
                   filename: 'azeemwaris2.jpg', content_type: 'image/jpeg')
user.save!

user = User.new(email: 'muiz.khan@devsinc.com',
                username: 'Muiz Khan',
                address: '1232 kdeff fdf',
                mobile: '03436789012')
user.password = '123456'
user.password_confirmation = '123456'
user.skip_confirmation!
user.avatar.attach(io: File.open('app/assets/images/profile/muiz.jpg'),
                   filename: 'muiz.jpg', content_type: 'image/jpeg')
user.save!

Coupon.create(name: 'AZEEM123', discount: 10, valid_til: '2021-12-10')
Coupon.create(name: 'AZEEM124', discount: 20, valid_til: '2021-12-10')

product = Product.new(name: 'Product Watch', price: 123,
                         description: 'This product is specially imported for classic collection, our watches
                         are providing best quality time for our cistomers',
                         quantity: 20,
                         serial_no: 121_212,
                         user_id: user.id)
product.images.attach(io: File.open('app/assets/images/gallery/popular1.png'),
                      filename: 'popular1.png', content_type: 'image/png')
product.save!

product = Product.new(name: 'Testing Watch', price: 223,
                         description: 'This product is specially imported for classic collection, our watches
                         are providing best quality time for our cistomers',
                         quantity: 20,
                         serial_no: 131_313,
                         user_id: user.id)
product.images.attach(io: File.open('app/assets/images/gallery/popular2.png'),
                      filename: 'popular2.png', content_type: 'image/png')
product.save!

product = Product.new(name: 'Ferrari Design', price: 323,
                         description: 'This product is specially imported for classic collection, our watches
                         are providing best quality time for our cistomers',
                         quantity: 20,
                         serial_no: 141_414,
                         user_id: user.id)
product.images.attach(io: File.open('app/assets/images/gallery/popular3.png'),
                      filename: 'popular3.png', content_type: 'image/png')
product.save!

product = Product.new(name: 'Best Product', price: 423,
                         description: 'This product is specially imported for classic collection, our watches
                         are providing best quality time for our cistomers',
                         quantity: 20,
                         serial_no: 151_515,
                         user_id: user.id)
product.images.attach(io: File.open('app/assets/images/gallery/popular4.png'),
                      filename: 'popular4.png', content_type: 'image/png')
product.save!
