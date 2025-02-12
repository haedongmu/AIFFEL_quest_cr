# 쿠키앤다이어트 앱(v1.1)
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
- 추가된 기능
  - 개인설정 : 프로필 이미지, 이름, 생년월일, 키, 몸무게 정보를 등록할 수 있고, 등록된 모든 정보를 초기화 할 수 있다. 
  - 음식촬영 : 음식사진을 촬영하면 AI가 사진 속에 포함된 음식의 종류와 수량, 칼로리 정보를 판독해서 앱으로 반환한다. 사용자는 이 정보가 맞으면 그대로 저장할 수 있고, 오류가 있을 경우 직접 수정할 수 있다. 음식정보는 음식일기로 자동저장된다.   
  - 음식일기 : 날짜별로 시간에 따라서 아침(오전 6시 ~ 오전 9시), 점심(오전 11시 ~ 오후 2시), 저녁(오후 5시 ~ 오후7시), 간식(나머지 시간) 4분류로 구분된다.  

# 앱 구조도(엑셀) - v1.0
![Image](https://github.com/user-attachments/assets/87b22f57-d18e-48b9-9fc0-02dc8696949a)

# 앱 구조도(엑셀) - v1.1
![Image](https://github.com/user-attachments/assets/b36eb7d3-ad5d-4a72-8588-12e5e2a79001)  

# 프로토타이핑 - v1.0  
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

# 프로토타이핑 - v1.1
<img src="https://github.com/user-attachments/assets/a1ef52f3-80da-4f9e-b3e7-45a134c244dc" width="200">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/user-attachments/assets/7be3b4db-34b0-4abb-abe5-100171898d60" width="200">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/user-attachments/assets/53e2e92c-8f2e-4a44-9c11-a4ddf557bc57" width="200">&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/user-attachments/assets/01829d45-4253-4ca5-8cd7-b8392130713c" width="200">&nbsp;&nbsp;&nbsp;&nbsp;

## 구현영상
[![구현 영상](https://drive.google.com/thumbnail?id=1xJwDIDCv_JGalvD591cE_9i0CsbNagPU)](https://drive.google.com/file/d/1xJwDIDCv_JGalvD591cE_9i0CsbNagPU/view)

# 페이지구현 - v1.0
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
4. 상점클래스  
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

# 페이지구현 - v1.1
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
4. 상점클래스  
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
profile_settings : 개인설정<추가>
profile_form : 개인설정 상세 화면<추가>
profile_model : 개인설정 데이터모델 구현<추가>
profile_actions : 개인설정 버튼클릭동작 구현<추가>
7. 파일구조도
   ![Image](https://github.com/user-attachments/assets/5d0913eb-b0a2-4f6e-bd05-77e5720f9c2f)

# 회고(참고 링크 및 코드 개선)
```
# 다트 문법을 명확하게 숙지하지 않은 상태에서 추가 기능 업데이트 작업을 진행하였는데, 버전 1.0에 비해 추가된 페이지에는 복잡한 코딩이 다소 많이 추가되면서 2일간 4페이지 정도만 작업을 진행할 수 있었습니다.  
# 직접 코딩을 하지 않고 GPT를 통해 코드를 작성하고, 디버깅도 진행하였기 때문에 원래 계획보다는 새로운 기능을 많이 추가하지 못하였습니다.
# 아무리 AI툴이 급속도로 발전하고 있다고 하여도 프로그래밍 언어를 전혀 모르는 상태에서는 효율적인 개발을 진행할 수 없다는 것을 깨달았습니다. 
```
