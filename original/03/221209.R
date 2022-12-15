install.packages("ggplot2")
library(ggplot2)
rm(list = ls())
setwd('C:/Rwork/03')
delirium = read.csv('03_치매환자현황.csv', header = T, sep = ',', fileEncoding = 'cp949')
head(delirium)

delirium$진단일수 <- difftime(delirium$데이터기준일자, delirium$진단일자)

qplot(거주지역, data=delirium, fill=거주지역) + ggtitle("거주지역별 치매환자")

class(delirium)
str(delirium)
delirium$진단일수 <- as.numeric(delirium$진단일수)
mean(delirium$진단일수)

delirium$나이 <- 2022 - delirium$출생년도 + 1
min(delirium$나이)
max(delirium$나이)
delirium$연령대 <- ifelse(delirium$나이 < 60, "50대",
                  ifelse(delirium$나이 < 70, "60대",
                  ifelse(delirium$나이 < 80, "70대",
                  ifelse(delirium$나이 < 90, "80대",
                  ifelse(delirium$나이 < 100, "90대",
                  ifelse(delirium$나이 < 110, "100대", "110대"
                  ))))))

head(delirium)
mode(delirium)

table(delirium$연령대)

qplot(거주지역, data=delirium, fill=거주지역) + ggtitle("거주지역별 치매환자")
qplot(연령대, data=delirium, fill=연령대) + ggtitle("연령대별 치매환자")
barplot(table(delirium$연령대), col = rainbow(6))

# =====================================================================

df1 = read.csv('03_치매환자현황.csv', header = T, sep = ',', fileEncoding = 'cp949')

# 거주지역, 성별에 따른 치매환자 빈도
tb1 = table(df1$거주지역, df1$성별)
tb1 <- as.data.frame(tb1)
tb1

qplot(거주지역, data=df1, fill=거주지역) + ggtitle("거주지역별 치매환자")
# 날짜 형식 변환 : "날짜면 연도 뽑을 수 있겠다 생각하세요"
as.Date(df1$진단일자)

# 날짜처리 패키지
install.packages('lubridate')
library(lubridate)

year(df1$진단일자)
df1$데이터기준일자 <- as.Date(df1$데이터기준일자)

df1$진단일수 <- abs(difftime(df1$진단일자, df1$데이터기준일자))
df1$진단일수 <- as.numeric(df1$진단일수)
mean(df1$진단일수)

rm(df)
df1$연령 <- year(df1$데이터기준일자) - df1$출생년도
df1$연령

# R에서 몫 연산은 %/%
# ifelse 안 쓰시고 몫을 쓰실 생각을 하셔도 된다.
df1$연령대 <- paste((df1$연령 %/% 10) * 10, '대', sep="")

# 90대 이상을 묶고 싶으면?
subset(df1, df1$연령대 == '100대')
df1$연령대 <- ifelse(df1$연령대 == '100대', "90대 이상", df1$연령대)

# 두개도 될 것같은데?
df1$연령대 <- ifelse((df1$연령대 == '40대'), "50대 이하", 
                  ifelse((df1$연령대 == '50대'), "50대 이하", df1$연령대))

head(df1)
qplot(연령대, data=df1, fill=연령대) + ggtitle("연령별 치매환자")

# =============================================================================

# 암발생자수
df2 = read.csv('03_암발생자수_.csv', header = T, sep = ',', fileEncoding = 'cp949')
head(df2)

# 열명 변경
names(df2) <- c("암종별", "성별", "연령별", "2019년", "2019년_1")

# 모든암 긁어오는 법 1:
df21 <- subset(df2, (df2$암종별=="모든 암(C00-C96)"))
df21

# 계와 연령미상을 제외하고 긁기
df2 %>% filter(!(연령별 %in% c("계", "연령미상")))

# 모든암 긁어오는 법 2:
df22 <- df2 %>% filter(df2$암종별 == "모든 암(C00-C96)" & !(연령별 %in% c("계", "연령미상")))
df22

unique(df22$연령별)

df22$연령대 <- ifelse(df22$연령별 %in% c("0-4세", "5-9세","10-14세", "15-19세", "20-24세", "25-29세", "30-34세", "35-39세"), "30대 이하", 
                   ifelse(df22$연령별 %in% c("40-44세",  "45-49세",  "50-54세",  "55-59세"), "40-50대",
                          ifelse(df22$연령별 %in% c("60-64세",  "65-69세",  "70-74세",  "75-79세"), "60-70대", "80대 이상"
                   )))
unique(df22$연령대)
names(df22) <- c("암종별",   "성별",     "연령별",   "y2019년",   "y2019년_1", "연령대" )
df22g <- df22 %>% group_by(연령대, 성별) %>% summarise(계 = sum(y2019년))
df22g
df22$y2019년 <- as.numeric(df22$y2019년)

qplot(연령대, data=df22, fill=성별) + ggtitle("연령별 암환자")
ggplot(data = df22g, mapping = aes(x = 연령대, y=계, fill=성별)) + geom_bar(stat = 'identity', position = position_dodge()) + ggtitle('연령대별 성별 분석') + theme(plot.title = element_text(hjust = 0.5, size = 20, face = 'bold'))
ggplot(mapping = aes(x=연령대, y=계, fill=성별), data=df22)
head(df22g)
