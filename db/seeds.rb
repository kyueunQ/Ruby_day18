# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: "aaa@gmail.com", password: "123456", password_confirmation: "123456")

genres = ["Horror", "Thriller", "Action", "Comedy", "Romance", "SF", "Adventure"]

images = %w[
    https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYhcUP0q4P1JtKl6OJ8a3XZBiFFlTvAgxxaYpacgwKoJsegAQ8
    https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTusgeEiQ0JYlM4_5LBHs4dbhtE6zzxAMVyFwBgQkVeVFuvLNffgw
    https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdyYtUbf44CH1jfBcJFRqBsp2yvshZ10LtVoN-ey9DOFB-ZuTt
    https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_eYjb96YQeNmpjzZ4QZv9w_RY4FOB6oHLZU1VBngL5AJptQfckg
    https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTB5tqXGKJP3Gb8VZtwTnBowVvr9wyrzDC_Bg4tgd35TLS224Vv
    https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9V0wdEtNc2oeiQrmJj1CwIurWywx7VUfSfD4aVmmwtpDo0sTCqw
    https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjgCvAY1rzoCKdsXehA2_ca-6XKOf_AaBVgQMhEczekjNGPVp_Bg
    https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMtdp6hJFc4bXYHXH1-T1I1al-9VLRnQDKhS4r2Cgtue7PmIBxuA
    https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUC0kczbFTXtRnNw3gQlWTG1ohg_jTLtzWLSOLvY2YGaX5sKKiNw
    https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRf-NEuG1Qiijy9JfjXiGdpzlLT_wQ3gObe3wDQyu_B84R_N_UN
    ]

30.times do
Movie.create(
    title: Faker::Movie.quote, genre: genres.sample, 
    director: Faker::Name.name, 
    actor: Faker::FunnyName.name, 
    description: Faker::Lorem.question, 
    remote_image_path_url: images.sample,
    user_id: 1)
end