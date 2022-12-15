# 해결문제 
# BMI는 몸무게와 키를 이용하여 체지방율을 측정하는 지수이다. 
# 자신의 몸무게와 키를 각각 변수 weight와 height에 저장하고 BMI지수를 계산해 본다. 
# 단, 키는 cm로 입력 받아서 처리한다.
# 
# BMI = 체중(kg) / (키(m) x 키(m))

# 키와 몸무게 scala입력
# height <- scan()
# weight <- scan()
# BMI <- weight / (height / 100) ** 2

setwd('C:/Rwork/01')
getwd()

print("키와 몸무게를 입력하시오: ")
data <- scan()

# 데이터 타입을 보고 싶으면 mode()
mode(data)

# 몸무게 수치 변환

# BMI 계산

# 키와 몸무게 vector입력
 
#문자열 입력
data <- readline()

# str_split을 쓰고 싶으면 일단 stringr 설치
install.packages("stringr")
library(stringr)

# 쪼개고 싶을 때는 str_split(쪼개고 싶은거, " ")
data <- str_split(data, " ")

# 자료형 확인
mode(data)

# 벡터로 형변환
data <- unlist(data)
as.vector(data)

# 벡터 확인
is.vector(data) 

# 숫자벡터로 변경
data <- as.numeric(data)
height <- data[1]
weight <- data[2]
BMI <- weight / (height / 100) ** 2

# 데이터프레임 입력
df <- data.frame()

# 클래스 내의 tuple의 데이터타입은 list고
mode(df)
# 클래스는 data.frame
class(df)

df <- edit(df)
df
# 데이터프레임 열명 변경
names(df) <- c("키", "몸무게")
# 새로운 변수를 추가하려면 df$"니가_추가하고_싶은_변수_이름 <- 
df$BMI <- df$몸무게 / (df$키 / 100) ** 2
mode(df)

# 해결문제 
# 국민건강보험공단 자료를 이용하여 BMI와 비만도를 구하시오.
# 비만도 
# 저체중	20 미만
# 정상	20 - 24
# 과체중	25 - 29
# 비만	30 이상
 
dfbmi <- read.csv('01_국민건강보험공단500.csv', header = T,  stringsAsFactors = F,fileEncoding = 'euc-kr')
dfbmi
mode(dfbmi)
dfbmi$BMI <- dfbmi$체중 / (dfbmi$신장 / 100) ** 2
head(dfbmi)

dfbmi$비만도 <- ifelse(dfbmi$BMI<20, "저체중", 
                    ifelse(dfbmi$BMI < 25, "정상",
                    ifelse(dfbmi$BMI < 30, "과체중", "비만"
                    )))

# 빈도 테이블
# 필드 별 레코드를 구하고 싶으면 table()
table(dfbmi$성별, dfbmi$비만도)
# 빈도 테이블 저장
write.csv(table(dfbmi$비만도, dfbmi$성별), 'frequency.csv', quote = F, fileEncoding = 'euc-kr')
write.csv(dfbmi, 'healthdiag.csv',  quote = F, fileEncoding = 'euc-kr')
# 해결문제
# 국민건강보험 관리공단의 건강검진 자료를 이용하여 대사증후군을 판별하시오.
# 높은 혈압(130/85mmHg 이상)
# 한 두개의 ifelse로 처리가 안 될 것같으면 필드를 파서 써라.
# TRUE/FALSE로 해본다면
df2$높은혈압 <- ((df2$수축기혈압>=130) | (df2$이완기혈압 >= 85))
head(df2)
# 높은 혈당(공복 혈당 100mg/dL 이상)
df2$높은혈당 <- df2$공복혈당>=100
# 높은 중성지방(트리글리세라이드 150mg/dL 이상)
df2$높은중성지방 <- df2$트리글리세라이드>=150
# 낮은 HDL 콜레스테롤 수치(남성은 40mg/dL 미만, 여성은 50mg/dL 미만)
df2$낮은콜레스테롤수치 <- ((df2$성별코드==1) & (df2$HDL콜레스테롤<40) | (df2$성별코드==2) & (df2$HDL콜레스테롤<50))
# 복부 비만(남성 90cm 이상, 여성 85cm 이상)
df2$복부비만 <- ((df2$성별코드==1) & (df2$허리둘레>=90) | (df2$성별코드==2) & (df2$허리둘레>=85))
# 판별
# 0 : 정상, 1~2 : 주의군, 3~5 : 위험군
df2$대사증후군수 <- df2$높은혈압 + 
                  df2$높은혈당 + 
                  df2$높은중성지방 + 
                  df2$높은중성지방 + 
                  df2$낮은콜레스테롤수치 + 
                  df2$복부비만

df2$판별 <- ifelse(df2$대사증후군수==0, "정상", 
                 ifelse(df2$대사증후군수<=2, "주의군", "위험군"))

names(df2)


head(dfbmi)

dfcheck <- read.csv('국민건강보험공단_건강검진정보_20211229.csv', sep = ',' ,header = T, stringsAsFactors = F, fileEncoding = 'euc-kr')
head(dfcheck)
names(dfcheck)
df2 <- dfcheck[c("성별코드", "허리둘레", "수축기.혈압", "이완기.혈압", "식전혈당.공복혈당.", "트리글리세라이드", "HDL.콜레스테롤")]

#NA 값 제거
df2 <- na.omit(df2)
tail(df2)

#열명 변경
names(df2) <- c("성별코드", "허리둘레", "수축기혈압", "이완기혈압", "공복혈당", "트리글리세라이드", "HDL콜레스테롤")
names(df2)

df2$성별 <- ifelse(df2$성별코드==1, "남", "여")
table(df2$판별, df2$성별)


