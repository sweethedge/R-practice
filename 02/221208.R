rm (list = ls())

getwd()
install.packages("readxl")
library(readxl)
dfx1 = read_excel("02_역주행사고.xlsx")
dfx1

# 테이블 분리 : subset 혹은 index
df1 <- subset(dfx1, dfx1$구분 == '전체')
df2 <- dfx1[dfx1$구분 == '역주행', ]
df1
df2

# 일반 교통사고
df3 <- df1
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

a = round(mean(df2$치명률), 1)
b = round(mean(df3$치명률), 1)

cat("최근 3년간 역주행 교통사고의 치명률이 ", a, '%로 일반 교통사고(', b, '%)', '보다 ', round(a/b, 1), '배 높은 것으로 나타났다.')

df3  

#df1: 원본, df2: 치명률, df3: 일반
install.packages('ggplot2')
library(ggplot2)

dftax = read.csv('02_부산광역시_지방세 체납현황.csv',  sep = ',' ,header = T, stringsAsFactors = F, fileEncoding = 'euc-kr')

names(dftax)
cols = unique(dftax$세목명)

makedf <- function (item) {
  temp <- subset(dftax, dftax$세목명 == item)
  ggplot(mapping = aes(x=과세년도, y=누적체납건수, fill=체납액구간), data=temp) + geom_bar(stat = "identity", position = position_dodge()) + ggtitle(item) + theme(plot.title = element_text(hjust=0.5, size=20, face='bold'))
}

dftax <- dftax[c('과세년도', '세목명', '체납액구간', '누적체납건수', '누적체납금액')]
makedf('지방소득세')

dftax$과세년도 <- as.factor(dftax$과세년도)

weather = read.csv('02_기상개황.csv',  sep = ',' ,header = T, stringsAsFactors = F, fileEncoding = 'euc-kr')

names(weather)
weather <- weather[c('월별.1.', '평균기온....', '평균상대습도....')]
names(weather) <- c('월별', '평균기온', '평균상대습도')
# 연간을 빼고 싶으면 이렇게
weather = weather[2:13, ]

weather$불쾌지수 <- round(0.81*weather$평균기온+0.01*weather$평균상대습도*(0.99*weather$평균기온-14.3)+46.3, 0)
weather$불쾌지수단계 <- ifelse(weather$불쾌지수 >= 80, "매우높음",
                         ifelse(weather$불쾌지수 >= 75, "높음",
                          ifelse(weather$불쾌지수 >= 68, "보통", "낮음")))

weather

barplot(table(weather$불쾌지수단계))

a = table(weather$불쾌지수단계)

barplot(a, col = c("red", "green", "skyblue"))

# ggplot으로 그리고 싶으면 일단 df로
a2 = as.data.frame(a)

  ggplot(mapping = aes(x=Var1, y=Freq, fill=Var1), data=a2) + geom_bar(stat = "identity", position = position_dodge()) + ggtitle('불쾌지수') + theme(plot.title = element_text(hjust=0.5, size=20, face='bold'))

contributors()
