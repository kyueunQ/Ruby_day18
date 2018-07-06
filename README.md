Day 



- pagination(kaminari) - gem
- hashtag (제목 중복, id d중복) - js + ajax
- 



*gem faker*

한 사람이 자료를 전부다 올렸다고 가정 

30개 정도 올리기

로랑 입생인가 거기서 영화 description 뽑기

영화 제목 가져오기

<br>

*db/seeds.rb*

```ruby
User.create(email: "aaa@gmail.com", password: "123456", password_confirmation: "123456")

genres = ["Horror", "Thriller", "Action", "Comedy", "Romance", "SF", "Adventure"]

images = %w[
    https://로 시작하는 이미지 주소 가져오기
	https://로 시작하는 이미지 주소 가져오기
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
```

- `%w` : `,` 를 사용할 필요 없이 엔터만을 통해 요소들을 구분함
- 





*접근 방법* :

- input 창에 글자를 한글자 입력할 때마다
- server로 해당 글자를 검색하는 요청을 보내고
- 응답으로 날아온 영화제목 리스트를 한 번에 보내준다. 



html에서 ajax 코드 작성 -> routes 작성 - 컨드롤러 - 뷰 js 파일 만들기 



## Pagination (gem `Kaminari`)



아래와 같이 `?`를 통해 

```

```



https://second-rails-kyueun.c9users.io/?page=3



** page 동작 방법

```
SELECT  "movies".* FROM "movies" LIMIT ? OFFSET ? 
```

LIMIT :  한 페이지의 제한 된 갯수 

OFFSET :  몇 개를 뛰어 넘고 보여줘야할지 







> 참고자료
>
> - remote image를 seedfile로 가져오기
>
>   https://github.com/carrierwaveuploader/carrierwave/wiki/How-to:-Upload-remote-image-urls-to-your-seedfile
>
> - 여러 페이지로 나누어 구현하기
>
>   https://github.com/kaminari/kaminari
>
> - 페이지 하단 쪽수 넘김 기능
>
>   https://github.com/KamilDzierbicki/bootstrap4-kaminari-views
>
> - 이미지 회전해서 보여주는 기능
>
>   https://getbootstrap.com/docs/4.0/components/carousel/#slides-only
>
> - gem faker
>
>   https://github.com/stympy/faker



>  Today's error
>
> - `Uncaught TypeError: Illegal invocation` 
>
>   : 변수 선언을 안 해줘서 발생한 문제