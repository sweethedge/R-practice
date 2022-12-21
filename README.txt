■ csv 파일을 긁고 싶을때
a <- read.csv('어쩌구.csv')

■ csv 파일을 만들고 싶을 때
write.csv(니가-짠-거, '어쩌구.csv', quote= F, 인코딩)

■ 엑셀파일을 긁고 싶으면
library(readxl)
read_excel()

■ 테이블에서 니가 원하는 것만 떼고 싶으면
subset(원본, 원본$칼럼 == '어쩌구') or
원본[원본$칼럼 == '어쩌구']

■ 칼럼 이름을 바꾸고 싶으면
원본[원본$칼럼1] <- "칼럼2"

■ ggplot + 껌바
a <- as.data.frame(a)
class(a)
a = ggplot(data = , mapping = aes(x=x축, y=y축, fill=니가 그리고 싶은 바색깔. x축이랑 똑같이 집어넣으면 잘 돌아간다))
b = a + geom_bar(stat = "identity")
c = b + ggtitle(title) + theme(plot.title = element_text(hjust=0.5)

■ 개쉬운 barplot
1. table
2. a = barplot(table)
3. b = barplot(a, col = *, xlab = '어쩌구', ylab = '저쩌구')

■ 좀 많이 쉬워진 ggplot
1. 테이블 짜라
a <- table(어쩌구)
2. 그걸 as.data.frame
b <- as.data.frame(a)
3. 그리면 됨
ggplot(mapping = aes(x=x축, y=y축, fill=x축), data=a) + geom_bar(stat = "identity")

■ 날짜계산
difftime(날짜1, 날짜2)
날짜1에서 날짜2를 뺀 값을 알려준다
헷갈리면 abs(difftime(날짜1, 날짜2))

■ 파이프 쓰는 법
1. library(dplyr)
2. a %>% filter(어쩌구 == '') %>% filter (저쩌구 != '')

■ 특정 행, 렬 보는 법
a[1,]
a[,1]
a[(1:3),]

■ 뭘 그리려고 하는데 y축이 잘 안나온다
y축에 숫자말고 다른게 들어가 있나?
is.numeric()

■ 상관계수 알고 싶을 때
cor(★, method="")
default가 제일 많이 쓰는 Pearson. kendall이나 spearman도 쓸 수 있다.

■ hitmap 그리고 싶을 때 corrgram
corrgram(★, upper.panel = panel.conf)

■ 상관계수 matrix 보고 싶을때 chart.correlation(★)

■ 숫자를 알아내고 싶으면 회귀모델 적용하기
1. x <- sample(1:nrow(★), percentage*nrow(★))
2. train / test
-- train <- ★[x, ]
3. model <- lm(y ~ x, data=train)
4. model을 찍어보면 예측치에 해당하는 f(x)를 구할 수 있음.

■ 분류모델이라면 ctree
library(party)
model <- ctree(y ~ x, data=train)
predict is a generic function for predictions from the results of various model fitting functions. The function invokes particular methods which depend on the class of the first argument.
predict (object, ...)
object	a model object for which prediction is desired.
...	additional arguments affecting the predictions produced.

pred1 <- predict(model1, test)

그걸로 test 데이터와 비교하고 싶을 때는 predict
predict1 <- predict(model, test)

■ 모델에 대한 평가
1. RMSE Root Mean Square Error
- RMSE <- sqrt(mean(test$actual_data - predict1)^2)

2. 혼돈행렬 만들어서 n으로 나누기
- 그전에..
-- 아닌 걸 맞다고 하면 제1종오류(α)
-- 맞는 걸 아니라고 하면 제2종오류
-- 아예 잘못 잡았으면 제3종오류

t <- table(test$thingy, pred)

(t[i,i] + t[i+1, i+1] + ... / sum(t))


