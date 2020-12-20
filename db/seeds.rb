User.create!(
  {
    email: "admin@example.com",
    is_admin: true,
    password: "12345678",
    password_confirmation: "12345678",
    name: 'Admin',
    address: {
      phone_number: '9545225923',
      address_line: 'Sahani Para',
      street: 'Sarmathura',
      city: 'Dholpur',
      state: 'Rajasthan',
      pin_code: '328026',
      landmark: 'Near railway station'
    }
  }
)