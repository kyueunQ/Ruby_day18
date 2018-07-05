# Day 17. '좋아요 버튼' + 댓글 기능



- 좋아요 버튼 + 개수 넣고 변화하는 것

- 댓글(ajax) 입력 + 삭제 + 수정(해당 댓글 위치에서 수정 가능토록)
  - 댓글 입력시 글제제한(front + back)
- 별점주기(좋아요 버튼 응용)
- pagination(kaminari)





*접근방법*

- 댓글을 입력받을 폼 작성
- form(요소)이 제출(이벤트)될 때(이벤트 리스너)
- 댓글을 쓰고밑에는 저장되는 그리고 보니까 적은 내용은 이미 날아간
-  ajax 요청으로 내용물을 받아서 서버에 '/create/comment'로 요청을 보낸다.
- 보낼 때는 내용물과 현재 보고 있는 movice의 id 값도 같이 보낸다.
- 서버에서 저장하고, response로 보낼줄 js.erb 파일을 작성한다.
- js.erb 파일에서 댓글이 표시될 영역에 등록된 댓글의 내용을 추가한다.



> The `.append()` method inserts the specified content as the last child of each element in the jQuery collection (To insert it as the *first* child, use [`.prepend()`](http://api.jquery.com/prepend/)). 



*comment model 만들기*

- column : user_id, movie_id, contents
- association 
  - movie(1) - comment(N)
  - user(1) - comment(N)
- url ("/movies/:movie_id/comments", method: post)인 ajax 코드완성



`$ rails g model`





*접근방법*

- 댓글에 있는 삭제 버튼(요소)을 누르면(이빈트 리스너)
- 해당 댓글이 눈에 안보이게 되고 (이벤트 핸들러),
- 실제 db에서도 삭제가 된다 (ajax)



```erb
    $('.destroy-comment').on('click', function(){
        console.log("destroyed!! ");
       $(this).parent().remove(); 
    });
```

- parents 라고 했을 시 상위 태그들을 모두 데리고 옴
- 



*접근방법*

- 수정 버튼을 클릭하면
- 댓글이 있던 부분이 입력창으로 바뀌면서 원래 있던 댓글의 내용이 입력창에 들어간다.
- 수정버튼은 확인 버튼으로 바뀐다.



*한 줄 당 한 코드*

- 내용 수정 후 확인 버튼을 클릭하면
- 입력창에 있던 내용물이 댓글의 원래 형태로 바뀌고
- 확인 버튼은 다시 수정버튼으로 바뀐다.
- 입력창에 있던 내용물으 ajax로 서버에 요청을 보낸다.
- 서버에서는 해당 댓글을 찾아 내용을 업데이트한다.





*1. 한 번에 하나씩만 수정하기(javascript만 사용해서 4줄)*

- 수정 버튼을 누르면

- 전체 문서 중에서 `update-comment` 클래스를 가진 버튼이 있는 경우에

- 더 이상 진행하지 않고 이벤트 핸들러를 끝냄

  return false;

어떻게 동작할지 생각하기 + ajax 코드 생성(요청할 url 설정, routes에서 잡아주고, controller와 action에 요청보내기)



### Template literals

