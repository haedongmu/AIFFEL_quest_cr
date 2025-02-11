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
  - 음식촬영 : 음식사진을 촬영하면 AI가 사진 속에 포함된 음식의 종류와 수량, 칼로리 정보를 판독해서 앱으로 반환한다. 사용자는 이 정보가 맞으면 그대로 저장할 수 있고, 오류가 있을 경우 직접 수정할 수 있다. 음식정보는 음식일기로 자동저장된다.   
  - 음식일기 : 날짜별로 시간에 따라서 아침(오전 6시 ~ 오전 9시), 점심(오전 11시 ~ 오후 2시), 저녁(오후 5시 ~ 오후7시), 간식(나머지 시간) 4분류로 구분된다.  

# 앱 구조도(엑셀)
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

# 회고(참고 링크 및 코드 개선)
```
# 총개발시간 : 2일
# GPT-4o : 90%, GPT-o3 : 10%
# 기획 및 디자인과 개발까지는 총 1일이 소요되었고, 오류테스트에 추가적으로 1일이 소요되었습니다.
# 예전 같으면 한 달은 족히 걸렸을 법한 개발분량이었습니다.
# 앞으로 프로그래밍은 GPT를 얼마나 잘 사용하느냐에 따라 생산성이 크게 좌우될 것이라고 봅니다.
# 초기 개발은 GPT-4o를 사용하여 빠르게 진행하였으나,
# 결제 처리부분에서 상당히 많은 시간이 소요되면서 때마침 GPT-o3가 출시되어 교체투입하였는데,
# 놀라울 정도로 빠른 속도로 문제를 해결하였습니다.
# 그런데 운동스케줄을 생성하는 부분에서는 GPT-o3도 고전하여,
# 다시 GPT-4o로 전환하여 진행하였습니다.
# 이 부분에서는 GPT-4o도 마찬가지로 고전하였으나, 코드를 한줄씩 디버깅하면서 진행하자고 제안하고
# 알고리즘을 직접 불러주고, 코드로 타이핑하는 것만 하라고 해서 결국 코드를 완성할 수 있었습니다.
# GPT-o3는 확실히 GPT-4o보다 월등히 나아진 모습을 보여주기는 하였으나, 여전히 크게 어렵지 않은 부분에서 고전하는 모습을 보였습니다.
# 아직은 AGI 완성까지는 갈 길이 멀다는 느낌을 받았습니다.
# 앱 구조도는 엑셀로 작성한 후 화면을 갭처하였습니다.(툴 사용법이 어려웠기 때문)
# 프로토타이핑은 따로 작성하지 않고, 실제 개발된 앱화면을 캡처하였습니다.(GPT를 사용할 경우 기획과 동시에 개발가능하기 때문)
# 다국어지원과 다크테마는 설정페이지만 만들고 기능은 미구현입니다.
# 현재 GTP는 노코드툴 수준까지 발전하지는 못하였으나,
# 코드를 잘 아는 사람이 사용할경우 기존 방식보다 30배 이상의 생산성을 향상시킬 수 있다는 것을 확인하였습니다.

```
