# 구현화면
<img src="https://github.com/user-attachments/assets/c26ab434-9b94-4fd9-86d3-3850b0799e51" width="300">
<img src="https://github.com/user-attachments/assets/6d52c451-8c35-4c1c-8d5f-4167dac2a84e" width="300">
<img src="https://github.com/user-attachments/assets/0330bee7-c888-4403-8a3f-85e258a74407" width="300">

# 디버그화면
Response Status Code: 200  
Response Body: {"predicted_label":"jellyfish","prediction_score":"0.9999174"}  
Parsed Data: {predicted_label: jellyfish, prediction_score: 0.9999174}  
Response Status Code: 200  
Response Body: {"predicted_label":"jellyfish","prediction_score":"0.9999174"}  
Parsed Data: {predicted_label: jellyfish, prediction_score: 0.9999174}  

# 에러난 부분
예측확률을 버튼을 눌렀을 때 처음에는 '404' 오류가 나왔습니다. 이 오류는 url 경로가 잘못된 경우에 발생합니다.
코드를 검토해 보니 Uri.parse(enteredUrl + endpoint), // API 요청 URL 로 되어 있었고, 이것을 Uri.parse(enteredUrl + 'sample') 로 수정하니 정상 작동하였습니다.
GPT로 수정하다 보니 발생한 오류였는데 디버그 화면에서 실제값을 정상적으로 받아왔는지를 체크함으로써 오류를 해결할 수 있었습니다.

# 회고
오후 수업이 시작했을 때는 취업지원센터에 있었기 때문에 코딩 방향을 제대로 듣지 못해, 외출복귀 후 한참 고민하다가 다른 분들이 하는 것을 보고 코딩방향을 제대로 알수 있었습니다.  
어제 배운 내용을 토대로 약간의 변형을 가하는 형태였는데, 아이펠 서버가 몇 차례 말썽을 일으키면서 시간이 많이 지체되었습니다.  
몇 번 로그아웃 후 재로그인 하는 과정에서 서버는 정상 작동하여, 프로젝트를 잘 마무리 할 수 있었습니다.

# AIFFEL_quest_cr
# AIFFEL Campus Online Code Peer Review Templete
- 코더 : 코더의 이름을 작성하세요.
- 리뷰어 : 리뷰어의 이름을 작성하세요.


# PRT(Peer Review Template)
- [x]  **1. 주어진 문제를 해결하는 완성된 코드가 제출되었나요?**
네 잘 되었습니다.
    
- [x]  **2. 전체 코드에서 가장 핵심적이거나 가장 복잡하고 이해하기 어려운 부분에 작성된 
주석 또는 doc string을 보고 해당 코드가 잘 이해되었나요?**
![image](https://github.com/user-attachments/assets/78ece875-b92a-480e-bf75-23806098f0f1)

이부분때문에 에러가 난거 같아서 이 코드를 선택했습니다.
        
- [x]  **3. 에러가 난 부분을 디버깅하여 문제를 해결한 기록을 남겼거나
새로운 시도 또는 추가 실험을 수행해봤나요?**
네 404오류가 나서 여러가지 시도를 하시고 잘 해결하셨습니다.

        
- [x]  **4. 회고를 잘 작성했나요?**
오류가 난 부분을 잘 회고하셨고 정확한 이유를 작성해 주셨습니다.

- [x]  **5. 코드가 간결하고 효율적인가요?**
이해하는데 어렵지 않고 간결합니다.

# 회고(참고 링크 및 코드 개선)
```
이번 프로젝트는 코드가 크게 다르지 않아도 오류가 날수가 있어서 힘들었습니다.
오류가 났을때 같이봤지만 찾기가 상당히 힘들었습니다.
```
