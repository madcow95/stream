# 영화 예고편 제공 사이트 - 개인 프로젝트

## :small_blue_diamond: 소개
    'MOVIE'는 영화 예고편, 간략한 정보, 검색 기능, 영화 추천 게시판 기능을 제공하는 페이지 입니다.

## :small_blue_diamond: 기획의도
    영화를 좋아하는 저는 영화에 대한 정보를 얻고 서로 추천하는 영화에 대해 이야기를 나누는 페이지를 만들고 싶어 제작하게 되었습니다.

<!-- ## :small_blue_diamond: 시연영상  (클릭시 영상이 재생됩니다) -->


## :small_blue_diamond: 주요 개발 내용
    - Java 기반의 Spring MVC 서버 백엔드 개발
    - Naver 영화 검색 API를 이용한 영화 검색
    - YouTube iFrame API를 이용한 영화 예고편 제공
    - Spring Security를 이용한 회원 정보 관리
    

## :small_blue_diamond: 제작 기간 ( 3주 - 2021/5/21 ~ 6/11 )

## :small_blue_diamond: Overview
### 0. 메인페이지(Spring Security에서 hasRole을 사용해 권한에 따라 보이는 화면이 다르게 했습니다.)

![화면 캡처 2021-08-05 202542](https://user-images.githubusercontent.com/78129823/128342959-5cea1020-7574-4a59-af18-827efdb6b6bf.png)
<div align="center"> 메인화면 입니다. </div>
<hr>

![화면 캡처 2021-08-05 202922](https://user-images.githubusercontent.com/78129823/128342819-84ec7ab5-ff7c-4086-9228-1c58d8998e5d.png)
<div align="center"> 메인화면에서 로그인(LOGIN)을 클릭했을 때 입니다. </div>
<hr>

![화면 캡처 2021-08-05 203209](https://user-images.githubusercontent.com/78129823/128343131-88724ea8-3a7d-4162-b101-a3ff2e925db9.png)
<div align="center"> 로그인을 했을 때 메인 화면 입니다. </div>
<hr>

### 1. 회원가입
![화면 캡처 2021-08-06 102115](https://user-images.githubusercontent.com/78129823/128441571-501ffc09-c08e-4801-a784-2de033a2a9a1.png)
<div align="center"> 회원가입(JOIN)을 클릭했을 때 입니다. </div>

### 1-1. 아이디 중복검사
![id](https://user-images.githubusercontent.com/78129823/128442644-6d19744e-7596-410d-aef1-e25133ee7fa5.gif)     ![idfail](https://user-images.githubusercontent.com/78129823/128442855-c30db8d0-c06b-42a0-a858-95ea9ba7543d.gif) 
<div align="center"> keyup과 ajax로 DB에 일치하는 결과가 있는지 조회하여 유효성 검사를 했습니다.</div>

### 1-2. 비밀번호 유효성 검사
![pwd](https://user-images.githubusercontent.com/78129823/128444151-8c82f5d9-c152-43d8-8c78-b2567df5257b.gif)
<div align="center"> keyup을 사용하여 유효성 검사를 했습니다. </div>

### 1-3. 회원가입 완료
![가입](https://user-images.githubusercontent.com/78129823/128465396-7af56808-c629-4079-8860-bdcdaf7f8008.png)
![bcr](https://user-images.githubusercontent.com/78129823/128465627-ad58d31b-d50e-48b3-85c0-9237240e14e6.png)
![auth](https://user-images.githubusercontent.com/78129823/128465741-385db66d-beb3-4db3-aee2-49a279157ef9.png)
<div align="center"> 회원가입이 완료되면 비밀번호가 BcryptEncoder를 통해 암호화 되고, 
    ROLE_MEMBER 권한을 부여해 DB에 저장시켰습니다. </div>

### 2-1 영화 검색 기능
![ms](https://user-images.githubusercontent.com/78129823/128464132-31b44a97-dfae-4ed5-90be-938232e0537c.gif)
<div align="center"> Ajax로 검색어를 Naver 영화 검색 API를 통해 취득한 데이터를
DB에 저장하는 동시에 별점순으로 정렬하여 화면에 출력시켰습니다.</div>
<!-- ### 1. 유저 로그인 (소셜 로그인)
![팀-로그인](https://user-images.githubusercontent.com/78129881/128335078-9b0f3c69-eeeb-4d93-b134-662d8568b87b.jpg)
<div align="center"> 카카오와 구글 API를 이용한 소셜로그인 구현 (OAuth)</div>

### 2. 모임게시판
![팀-모임게시판](https://user-images.githubusercontent.com/78129881/128335143-8e508e9a-bc18-4109-878f-35f95284c04b.jpg)
<div align="center"> 각 카테고리별로 모임을 조회할수 있습니다. </div>

### 3. 운동 메인페이지


### 7. 마이페이지 모집 글 내역
![팀-마이페이지모집글내역](https://user-images.githubusercontent.com/78129881/128335233-862a926f-98e8-4842-9936-c4acb5422719.jpg)
<div align="center"> 마이페이지에서는 자신이 개설한모임과 신청한모임, 참여중인 모임, 완료중인 모임을 확인할수 있습니다. </div>

## :small_blue_diamond: ERD
![table_erd_수정_210804](https://user-images.githubusercontent.com/78129881/128328964-0ee64b71-e73f-463a-9136-0188ea0f3469.png)

## :small_blue_diamond: Tech stack
![backendd](https://user-images.githubusercontent.com/78129881/128328994-d3bb1f68-f9c9-4801-8a28-174cc019d885.jpg) -->

<!-- ## :small_blue_diamond: 담당 기능

## :small_blue_diamond: 역할 분배 -->
### 3-1 영화 예고편 재생
![main](https://user-images.githubusercontent.com/78129823/128464989-0c682098-8ded-4b4e-9694-5183cf97087a.gif)
<div align="center"> 2-1에서 저장된 데이터를 메인화면에서 캐러셀으로 보여주었고, 해당 포스터 클릭시
Youtube API를 사용하여 해당 포스터의 제목에 해당하는 예고편을 modal안에 출력 시켰습니다.</div>

 # <div align="center"> 감사합니다. </div>
