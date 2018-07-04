# Day 16.  jQuery , Ajax



## 1. jQurey

<br>

$("선택자")

```js
# . --> class
$(".btn")

# # --> id
$('#title')
```

<br>

### 첫번째 형태

```js
$('.btn').이벤트명(function() {});

# Example.
$('.btn').mouseover(function() {
	alert("건드리지마 ㅠ")
});
```

- javascript의 getElementByClassName과 달리 **일괄 적용**이 됨

<br>

### 두번째 형태

```js
$('.btn').on('이벤트명', function() {});

# Example.
$('.btn').on('mouseover', function() {
	console.log("클릭 클릭");
});
```

<br>

*응용하기*

- 마우스가 버튼 위에 올라갔을 때, 버튼에 있는 `btn-primary` 클래스를 삭제하고 btn-danger 클래스를 준다. 버튼에서 마우스가 내려왔을 때 다시 `btn-danger` 클래스를 삭제하고 `btn-primary`클래스를 추가한다. 

- 여러개의 이벤트 등록하기

- 요소에 class를 넣고 빼는 jQuery function을 찾기

  

```js
var btn = $('.btn');

btn.on('mouseenter mouseout', function() {
	btn.removeClass("btn-primary").addClass("btn-danger");
})


btn.on('mouseenter mouseout', function() {
	btn.toggleClass('btn-danger').togleClass('btn-primary');
});
```

<br>

### toggleClass : remove + add 기능

```js
var btn = $('.btn');

btn.on('mouseenter mouseout', function() {
	$(this).toggleClass('btn-danger').toggleClass('btn-primary');
		console.dir(this);
		console.dir($(this));
});


# a.btn.btn-danger
# jQery.fn.init(1)

# a.btn.btn-primary
# jQuery.fn.init(1)
```

- `this` : event가 발생한 자기 자신
- `console.dir(this);` : html 그자체가 출려됨



<br>

*응용하기*

- 버튼에 마우스가 오버됐을 때, 상단에 있는 이미지의 속서에 `style` 속성과 `width: 100px;`의 속성 값을 부여하기

```js
btn.on('mouseover', function() {
	$('img').attr('style', "width: 100px")
		
});

# 속성 값 가져오기
# 댓글 여러 개 중에 하나만 삭제할 때 활용함
$('img').attr('style');
```



- 버튼(요소)에 마우스가 오버(이벤트)됐을 때(이벤트 리스너), 이벤트가 발생한 버튼($(this))과 상위에 있는 요소(parent) 중에서 `card-title`의 속성을 갖은 친구를 찾아(find) 텍스트(text)를 변경시킨다.

```js
btn.on('mouseover', function() {
		$('.card-title').text("Don't touch");
});
```



```js
btn.on('mouseover', function() {
		$(this).parent().find('.card-title').text("ddd");
		
});
```

- jQuery  siblings와 parent 차이점은?



### 텍스트 변환기(오타 생성기)

*index.html*

```html
<textarea id="input" placeholder="변환할 텍스트를 입력해주세요."></textarea>
<button clss="translate">바꿔줘</button>
<h3></h3>
```

- input에 들어있는 텍스트 중에서 '관리' -> '고나리', '확인' -> '호가인', '훤하다' -> '허누하다'의 방식으로 텍스트를 바꾸는 이벤트 핸들러 작성하기
- https://github.com/e-/Hangul.js 에서 라이브러리를 받아서 자음과 모음을 분리하고, 다시 단어를 합치는 기능 살펴보기
- String.split('') : `''` 안에 있는 것을 기준으로 문자열을 잘라준다 (return type: 배열)
- Array.join('') : 배열에 들어있는 내용을 합치기
- Array.map(function(el){ }) : 배열을 순회하면서 하나의 요소마다 function을 실행시킴 (el: 순회하는 각 요소 return type: 새로운 배열)



*접근 방법*

1. textarea에 있는 내용물을 가지고 오는 코드
2. 버튼에 이벤트 리스너(click)을 달아주고, 핸들러에는 1번에서 작성한 코드를 넣는다.
3. 1번 코드의 결과물을 한글자씩 분해해서 배열로 만들어 준다.
4. (조건) 두번째([1]), 세번째([2]) 배열이 모음 & 네번째([3]) 내용물 존재
5. (switch) 세번째([2])와 네번째([3]) 위치를 바꿔줘야 함
6. 결과물로 나온 배열을 문자열로 이어준다. ('join')
7. 결과물을 출력해줄 요소를 찾는다.
8. 요소에 결과물을 출력한다.



```
<script type="text/javascript">

  $('.translate').on('click', function() {
    var input = $('#input').val();
    var result = translate(input);
    $('h3').text(result);
    console.log(result);
  });
```



*index.html*

```js
function translate(str) {
  // 글자마다 자르기
  return str.split('').map(function(el) {
    // 글자 분해하기, el이란 변수로 넣기
    var d = Hangul.disassemble(el);
    
    if(d[3] && Hangul.isVowel(d[1]) && Hangul.isVowel(d[2])){
      var tmp = d[2];
      d[2] = d[3];
      d[3] = tmp;
    }
    return Hangul.assemble(d);
  }).join('');
}

```

- `d[3]` :  

<br>

<br>

## 2. Ajax

- javascript 에서 다른 문서에서 import를 한 것과 비슷하게 
- javascript 동작하는 중간에 서버에 요청을 보낸다고 생각하기 (화면전환이 없음)
- 필요한 정보는 url과 http method



*기본형태*

```javascript
$.ajax({
    url: 어느 주소로 요청을 보낼지,
    method: 어떤 http method 요청을 보낼지,
    data: {
        k: v 어떤 값을 함께 보낼지,
        // 서버에서는 params[k] => v
    }
})
```





## 3. '좋아요' 기능 구현

- 유저가 좋아요를 누르면 화면에 나오는 그런그런 하아
- 좋아요 --> 좋아요 취소 --> 좋아요



좋아요 모델 만들기

`$ rails g model like`  :  한 유저는 영화 영화에 하트, 영화도 많은 하트를 받을 수 있음 (m:n)

:: 조인 테이블



1. 좋아요 버튼을 눌렀을 때
2. 서버에 요청을 보낸다. (현재 유저와 유저가 보고있는 영화가 좋다고 하는 요청)
3. 서버가 할일
4. 응답이 오면 좋아요 버튼 --> 좋아요 취소 바꾸고, btn-info --> btn-warning으로 변경



*config/routes*

```ruby
Rails.application.routes.draw do
	...
  get '/likes/:movie_id' => 'movies#like_movie'
	...
end

```

- 특정 영화의 좋아요를 클릭했을 때 url로 연결시켜주기









##### action명과 일치되는 js형식의 view 파일 만들기

*views/movies/show.html.erb*

```js
<h1><%= @movie.title %></h1>
<hr/>
<p><%= @movie.description %></p>
<%= link_to 'Edit', edit_movie_path(@movie) %> |
<%= link_to 'Back', movies_path %><br/>
<button class="btn btn-info like">좋아요</button>
<script>
$(document).on('ready', function() {
    // jQuery로 like 버튼을 찾기
    $('.like').on('click', function() {
        console.log("like");
        $.ajax({
            url: '/likes/<%= @movie.id %>'
            
        });
    })
});
</script>
```

- `$(document).on('ready', function() {}` : document가 전부 로드 된 후에 javascript를 로드한다.



*views/movies/like_movie.js.erb*

```js
alert("좋아요 설정 완료");
```







> 참고문서
>
> - https://github.com/e-/Hangul.js  :  텍스트 변환기



> Today's error 
>
> - 입력 값을 받아오지 못할 때 --> 
> - 루비와 달리 javascrip는 return 값이 존재해야 함
> - redirect_to : get방식으로 또다른 url 페이지로 넘김