# 쿠키앤다이어트 앱 분석 및 역설계 하기
# 앱 정보
- 앱이름
  - 쿠키앤다이어트
- 시장(마켓)
  - 건강 및 다이어트 시장 성장: 글로벌 헬스케어 및 다이어트 시장은 꾸준히 성장 중이며, 특히 개인 맞춤형 식단 & 운동 솔루션에 대한 관심 증가.
  - 푸드테크와 피트니스의 융합: 주문과 칼로리 소모 연계를 통한 소비자 맞춤형 서비스 제공이 트렌드.
  - 모바일 중심의 건강 관리: 스마트폰을 활용한 건강 관리 앱 사용 증가.
- 타켓
  - 건강 관리에 관심 있는 20~40대 직장인: 바쁜 일상 속에서 편리한 다이어트 솔루션 필요.
  - 운동 초보자 & 다이어트 중인 사용자: 자동 운동 코스 추천으로 지속 가능성 증가.
  - 배달 음식을 자주 시키는 소비자: 건강한 선택을 유도.


# 앱 구조도
![Image](https://github.com/user-attachments/assets/87b22f57-d18e-48b9-9fc0-02dc8696949a)

# 프로토타이핑
<img src="https://github.com/user-attachments/assets/c90560c3-4066-4a8e-9e01-04b7111fe7f2" width="200">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/user-attachments/assets/d180e0e7-7c32-4d38-a9cb-0f45b4880fa2" width="200">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/user-attachments/assets/2919c0cd-e8a6-4bcc-964b-e92f00c044b4" width="200">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/user-attachments/assets/3f464b06-a500-4ce2-b9f1-ca8c35671be1" width="200">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/user-attachments/assets/1cbe4d30-b508-450c-a53d-a92a16c772e0" width="200">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/user-attachments/assets/8f19fd49-e682-45f0-a0f0-dfc38ac1357e" width="200">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/user-attachments/assets/55eb1cb7-20d7-4874-a1cc-9ed497a787d4" width="200">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/user-attachments/assets/18095ffe-a6e4-4950-847e-4a8c62506c24" width="200">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/user-attachments/assets/392eb057-a0dd-481a-952a-c27b792b1ae2" width="200">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/user-attachments/assets/289aa0ce-4109-4f6e-a838-e65de3fb2f12" width="200">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/user-attachments/assets/d008df2b-aba1-4d63-8f54-4a352789439b" width="200">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/user-attachments/assets/5ed879d8-0abf-46c9-a593-10536529af30" width="200">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/user-attachments/assets/942161b3-fc8d-4932-93e9-e39e12234dfc" width="200">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/user-attachments/assets/03e33cd5-cb19-4cc9-a1c1-7e19f2595e12" width="200">&nbsp;&nbsp;&nbsp;&nbsp;

## 구현영상
[![구현 영상](https://drive.google.com/thumbnail?id=1xJwDIDCv_JGalvD591cE_9i0CsbNagPU)](https://drive.google.com/file/d/1xJwDIDCv_JGalvD591cE_9i0CsbNagPU/view)

# 페이지구현
1. 공통클래스  
cart_icon.dart : 카트  
custom_app_bar.dart : 앱바  
custom_nav_bar.dart : 네비게이션바  
2. 서랍클래스
app_drawer.dart
base_scaffold.dart
3. 메인화면
main.dart : 온보딩
home_screen.dart : 홈화면
4.상점클래스
menu_items.dart : 메뉴리스트 등록
menu_screen.dart : 메뉴
menu_detail_screen.dart : 메뉴상세
order_screen.dart :주문
payment_screen.dart : 결제
order_history_screen.dart : 주문내역
order_detail_screen.dart : 주문내역상세
5. 운동클래스
exercise_data.dart : 운동종목 등록
exercise_settings_screen.dart : 즐기는 운동 설정
exercise_schedule_screen.dart : 운동스케줄
generate_exercise_schedule.dart : 운동스케줄생성(운동스케줄 페이지 접속시 새로운 주문내역이 있을 경우)
exercise_schedule_detail_screen.dart : 운동스케줄상세
6. 설정클래스
language_selection_screen.dart : 언어선택
theme_selection_screen.dart : 테마선택

# 회고(참고 링크 및 코드 개선)
```
# 리뷰어의 회고를 작성합니다.
# 코드 리뷰 시 참고한 링크가 있다면 링크와 간략한 설명을 첨부합니다.
# 코드 리뷰를 통해 개선한 코드가 있다면 코드와 간략한 설명을 첨부합니다.
```
