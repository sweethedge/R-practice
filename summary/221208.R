rm (list = ls())

getwd()
setwd('c:/Rwork/02')
install.packages("readxl")
library(readxl)
dfx1 = read_excel("02_역주행사고.xlsx")
dfx1

# 테이블 분리 : subset 혹은 index
df1 <- subset(dfx1, dfx1$구분 == '전체')
df2 <- dfx1[dfx1$구분 == '역주행', ]
df1
df2

# df3를 만든 다음
df3 <- df1
# 원래 전체라고 되어 있던 칼럼을 일반이라고 바꿨다.
df3$구분 <- "일반"
# 행렬의 각각을 빼려면 이렇게
df3 <- df1[c("사고", "사망")] - df2[c("사고", "사망")]
df3

#치명률
df1$치명률 <- round((df1$사망 / df1$사고) * 100, 2)
df2$치명률 <- round((df2$사망 / df2$사고) * 100, 2)
df3$치명률 <- round((df3$사망 / df3$사고) * 100, 2)
df3

summary(df3)
mean(df2$치명률)
mean(df3$치명률)

# 역주행일 때의 치명률을 a라고 하고
a = round(mean(df2$치명률), 1)
# 그 외의 치명률을 b라고 잡았다.
b = round(mean(df3$치명률), 1)

cat("최근 3년간 역주행 교통사고의 치명률이 ", a, '%로 일반 교통사고(', b, '%)', '보다 ', round(a/b, 1), '배 높은 것으로 나타났다.')

df3  

#df1: 원본, df2: 치명률, df3: 일반
install.packages('ggplot2')
library(ggplot2)

dftax = read.csv('02_부산광역시_지방세 체납현황.csv',  sep = ',' ,header = T, stringsAsFactors = F, fileEncoding = 'euc-kr')

names(dftax)
cols = unique(dftax$세목명)

# function을 하나 만들 거다.
# 세목명이 item인 걸 temp에 대입하고
# 세목명이 그거인 걸로 ggplot을 하는 function 이름이 makedf
makedf <- function (item) {
  temp <- subset(dftax, dftax$세목명 == item)
  # geom의 bar 갯수를 정할 수 있는게 fill.
  ggplot(mapping = aes(x=과세년도, y=누적체납건수, fill=체납액구간), data=temp) + geom_bar(stat = "identity", position = position_dodge()) + ggtitle(item) + theme(plot.title = element_text(hjust=0.5, size=20, face='bold'))
}

# dftax 정리
dftax <- dftax[c('과세년도', '세목명', '체납액구간', '누적체납건수', '누적체납금액')]
# 위에서 만든 함수로 지방소득세를 한 번 뽑아보면..
makedf('지방소득세')

# 이건 왜 했을까?
dftax$과세년도 <- as.factor(dftax$과세년도)

weather = read.csv('02_기상개황.csv',  sep = ',' ,header = T, stringsAsFactors = F, fileEncoding = 'euc-kr')

names(weather)
# 일단 3개만 뽑아봤다
weather <- weather[c('월별.1.', '평균기온....', '평균상대습도....')]
# 이름도 좀 깔끔하게 바꾸고
names(weather) <- c('월별', '평균기온', '평균상대습도')
# 연간을 빼고 싶으면 이렇게
weather = weather[2:13, ]

# 공식에 따라서 만들어 준거
weather$불쾌지수 <- round(0.81*weather$평균기온+0.01*weather$평균상대습도*(0.99*weather$평균기온-14.3)+46.3, 0)
weather$불쾌지수단계 <- ifelse(weather$불쾌지수 >= 80, "매우높음",
                         ifelse(weather$불쾌지수 >= 75, "높음",
                          ifelse(weather$불쾌지수 >= 68, "보통", "낮음")))

weather

# barplot 그리는 2-step program
# 1. 테이블 만든다
# 2. 그린다
barplot(table(weather$불쾌지수단계))
# 색깔이 넣고 싶으면 만든 테이블을 받는 변수를 하나 만든다
a = table(weather$불쾌지수단계)

# 색깔도 넣고 label도 붙이고 그런 거는 help 보고 알아서 하시면 된다
barplot(a, col = rainbow(3), xlab = '불쾌지수단계', ylab = '기록', horiz = F)

# ggplot으로 그리고 싶으면 일단 df로
a2 = as.data.frame(a)
# 데이터프레임 열 이름이 Var1, Freq인건 좀 너무하니까 손 좀 보고
names(a2) <- c('단계', '빈도')
  ggplot(mapping = aes(x=단계, y=빈도, fill=단계), data=a2) + geom_bar(stat = "identity", position = position_dodge()) + ggtitle('불쾌지수') + theme(plot.title = element_text(hjust=0.5, size=20, face='bold'))

# 팔요하면 변수를 좀 사용해서 좀 더 보기 편하게 하셔도 된다.  
c = ggplot(mapping = aes(x=단계, y=빈도, fill=단계), data=a2)
# theme에서 plot.title은 element_text에서 상속을 받아서 쓰는 모양이다. horizontal justification은 0~1 사이의 값이라서 0.5를 준 거고.
c + geom_bar(stat = "identity") + ggtitle('title') + theme(plot.title = element_text(hjust=0.5))
