# Day 15. watcha 구현 + JavaScript

<br>

## 1. watcha 만들기

- 개요

  - scaffold 
  - user authenticate (devise)
  - comment model
  - image upload(local)

  

<br>

### 프로젝트 생성하기

`$ gem install rails -v 5.0.7`

 `$ rails _5.0.7_ new watcha`

`$ rails g scaffold movies` : movies controller와 movie model이 생성됨



*app/db/migrate/2018..._create_movies.rb*

```ruby
class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :genre
      t.string :director
      t.string :actor
      t.string :image_path
      
      t.integer :user_id

      t.text :description
        
      t.timestamps
    end
  end
end
```



*app/views/_form.html.erb*

```erb
<%= form_for(movie) do |f| %>
  <% if movie.errors.any? %>
    <div id="error_explanation">
      <h2><%= pluralize(movie.errors.count, "error") %> prohibited this movie from being saved:</h2>

      <ul>
      <% movie.errors.full_messages.each do |message| %>
        <li><%= message %></li>
      <% end %>
      </ul>
    </div>
  <% end %>

  <div class="form_group">
    <%= f.label :title %>
    <%= f.text_field :title, clss: "form-control" %>
  </div>
  
  <div class="form_group">
    <%= f.label :genre %>
    <%= f.text_field :genre, clss: "form-control" %>
  </div>
  
  <div class="form_group">
    <%= f.label :director %>
    <%= f.text_field :director, clss: "form-control" %>
  </div>
  
  <div class="form_group">
    <%= f.label :actor %>
    <%= f.text_field :actor, clss: "form-control" %>
  </div>
  
  <div class="form_group">
    <%= f.label :description %>
    <%= f.text_area :description, clss: "form-control" %>
  </div>
  
  <div class="form_group">
    <%= f.label :image_path %>
    <%= f.file_field :image_path, class: "form-control" %>
  </div>
  
  <div class="actions">
    <%= f.submit %>
  </div>
<% end %>

```

- <%= form_for(movie) do |f| %> 
  - `movie`라는 db와 연결, scaffold에서 컨트롤러와 모델명이 일치해야 form_for문을 사용할 수 있음
  - movie = Movie.new 혹은 = Movie.find_by(id)와 같이 값을 담기위해 만들어진 `movie`라는 상자라고 생각했을 때 빈 상자면 `new`와 연결, 채워진 상자라면 `edit`과 연결시켜줌
- 각 변수별로 `<div>`를 만들어주기



*app/controller/movies_controller.rb*

```ruby
class MoviesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
....

# Never trust parameters from the scary internet, only allow the white list through.
def movie_params
   params.require(:movie).permit(:title, :genre, :director, :actor, :description, :image_path)
    end
end
```

- `index`와 `show` views를 제외하고 나머지 views에서는 로그인이 된 상태여야 함
- `:movie`에서 오직 선언된 변수들만을 허용한다는 의미



<br>

### Gem file 설치하기

*Gemfile*

```ruby
# beautify
gem 'bootstrap', '~> 4.1.1'

# authentication
gem 'devise'

# file upload
gem 'carrierwave'

# db에 어떤 변수과 값이 담겨있는지 확인하는 용도
group :development do
  gem 'rails_db'
end
```

- Ruby 언어가 많은 기능을 탑재하고 있다보니 구동 속도가 느린 것을 보완하기 위해,  `Turbolinks`를 사용해 웹 어플리케이션 속도를 빠르게 만들 수 있다. 하지만 css 등을 사용할 때 오류를 많이 일으켜 우선 삭제해 둔다.

  - `gem 'turbolinks', '~> 5'`  *Gemfile*에서 삭제하기

  - *app/assets/javascripts/application.js* 에서 `turbolinks` 관련된 것 삭제

    ```js
    //= require jquery
    //= require jquery_ujs
    # //= require turbolinks  #삭제
    # //= require_tree .   #삭제 : javascript가 맨 마지막에 로드되도록 하기 위해 삭제
    # 아래 두 개 추가하기
    //= require popper
    //= require bootstrap
    ```

    - bootstrap 적용을 위한 설정 : *app/assets/stylesheets/application.scss* (← .css를 .scc로 변경하기)

      ```css
      @import 'bootstrap';
      ```

  - *app/views/layouts/application.html.erb* 에서 `turbolinks`와 관련된 부분만 제거해서 아래와 같이 수정할 것

    ```erb
    <%= stylesheet_link_tag    'application', media: 'all' %>
    <%= javascript_include_tag 'application' %>
    ```

<br>

### 로그인 구현, gem devise

`gem 'devise'` : *Gemfile*에 추가하기

`$ rails g devise:install` : 명령어 입력 후 수정 및 추가와 관련된 4가지 사항을 했는지 물어봄

<br>

1. 개발 환경 설정에 추가

   *config/environments/development.rb*

   ```
     # Don't care if the mailer can't send.
     config.action_mailer.raise_delivery_errors = false
     config.action_mailer.perform_caching = false
     # '회원가입시 확인 메일 보내기' 기능 관련 설정 추가
     # 실제 서버 배포시 제작한 서버의 것으로 수정하기
     config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
   ```

   

2. *config/routes* 에서 `root 'movies#index' ` 추가하기

   ```ruby
   Rails.application.routes.draw do
     devise_for :users
     root 'movies#index'
   end
   ```



<br>

### db 관계 설정

*app/models/movie.rb*

```ruby
belongs_to :user
```

- 유저에 종속됨을 설정함

  

*app/models/user.rb*

```ruby
has_many :movies
```



<br>

### 이미지 업로드를 위한 설정

`gem 'carrierwave'` : uploader 만들기 위해 *Gemfile*에 추가하기

`gem 'mini_magick'` : 이미지 조정을 할 수 있는 기능 구현을 위해 *Gemfile*에 추가

`$ bundle install`

`$ rails g uploader image`



*uploaders/image_uploader.rb* 

```ruby
class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  include CarrierWave::MiniMagick
  ...
  # Choose what kind of storage to use for this uploader:
  storage :file
  ...
  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [320, 180]
  end
```



*app/models/movie.rb*

```ruby
class Movie < ApplicationRecord
    # 해당 컬럼은 ImageUploader에서 관리할 것임
    mount_uploader :image_path, ImageUploader
    belongs_to :user
end
```

- `movie` db의 `image_path` 컬럼은 `ImageUploader`에서 관리할 것을 의미함

<br>

<br>

# 2. JavaScript

:  event를 등록하기 위해 사용함

```
document.getElementsByClassName('btn')
document.getElementByClassName('btn')
```

*입력하는 3가지 방법*

```javascript
console.log("hi")
console.error("erre")
console.dir(btn);   # btn에 해당하는 모든 정보를 보여줌
```

*대답해주는 4가지 방법*

<br>

<br>

### 이벤트 등록하기 (2가지 방법)

#### 첫번째 방법 

#### : 요소.on이벤트이름 = function(매개변수){  }

- 요소.on이벤트 리스너  =   function(매개변수) {이벤트 핸들러}
- 이벤트 = 요소 + 이벤트 리스너 + 이벤트 핸들러

<br>

*app/views/index.html.erb*

```javascript
<script>
var btn = document.getElementsByClassName("btn")
btn[0].onmouseover = function(){ alert("건들지마요") }
</script>
```

<br>

*응용하기*

1. 마우스를 오버하면 "건들지마요" alert()를 띄움

2. 마우스 오버를 3회 이상 하면 "그만! " 이라는 alert( )를 띄움

   - count를 어떻게 선언할지 생각해보기


```javascript
<script>
var btn = document.getElementsByClassName("btn")[0];
var count = 0;
var msg = "나 건드리지마 ";
btn.onmouseover = function(){
	count++;
	if(count > 3 ){
		msg = "그만해라"
    }
	alert(msg);
}
</script>
```

<br>

#### 두번째 방법 

#### : 요소.addEventListener("이벤트이름", 이벤트 핸들러)

```javascript
var btn = document.getElementsByClassName("btn")[1];
btn.addEventListener("mouseover", function(){
	alert("호옹");
});
```

<br>

<br>

### 함수 만들기 (3가지 방법)

```
# 1. 함수 표현식
var func = function() {
    alert("안녕");
}

# 2. 함수 선언식
function func1() {
    alert("안녕안녕");
}

# 3. 익명함수
btn.addEventListener("mouseover", function() {
  alert("안녕안녕안녕")
})
```

<br/>

*함수 표현식과 함수 선언식, 두 방법의 차이점은??*

```javascript
<script>

  func1();  # 실행되지 않음
  func2();  # 실행됨
  
 # 함수 표현식
 # 선언되기 이전에 사용 불가
  var func1 = function() {
    alert("안녕");
  }
  
  # 함수 선언식
  # 선언되기 이전에 사용 가능
  function func2() {
    alert("안녕안녕");
  }
  
</script>
```

<br>

*응용하기*

- 파란색 버튼(요소)에 마우스를 올리면(이벤트, 이벤트 리스너)

   해당 버튼(요소)의 class가 'btn btn-danger'로 변함

```javascript
var btn = document.getElementsByClassName("btn")[0];

btn.addEventListener("mouseover", function() {
  btn.setAttribute("class", "btn btn-danger")
})

btn.addEventListener("mouseout", function() {
  btn.setAttribute("class", "btn btn-primary")
})
```

<br>

- 버튼(요소)에 마우스를 오버(이벤트) 했더니(이벤트 리스너)
  그 위에 있던 글자(요소)들이 갑자기 이상한 문자열로 변함(이벤트 핸들러)

```javascript
var btn = document.getElementsByClassName("btn")[0];

btn.addEventListener("mouseover", function() {
  var text
  var title = document.getElementsByClassName("card-title")[0];
  console.dir(title);
  title.innerHTML = "touch touch";
})

btn.addEventListener("mouseout", function() {
  var title = document.getElementsByClassName("card-title")[0];
  title.innerHTML = "";
})
```

<br>

<br>

<br>



##### 이번주 계획

- 기본적인 JS 설명(front)
- 이벤트 동작시키기 jQuery+ajax
- 댓글 달기 + 수정 + 삭제
- 좋아요 + 별점 
- infinity scroll

```
p @instance.errors
```



*금요일*

- 사용자 기능정의

  - 사용자 입장에서 어떤 기능이 있으면 좋겠다

  - 페이지에 어떤 내용이 들어갈 것인지 명세하기 (금) 
    - 회원가입
    - 메인 페이지
    - 게시판 목차
    - 게시판 입력창
    - 게시판 수정창(입력창)
    - 게시글 보기창



> 개발/test/배포 환경 3가지가 존재함

