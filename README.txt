■ csv 파일을 긁고 싶을때
뭐시기 <- read.csv('어쩌구.csv')

■ csv 파일을 만들고 싶을 때
write.csv(니가-짠-거, '어쩌구.csv', quote= F, 인코딩)

■ 엑셀파일을 긁고 싶으면
readxl 라이브러리

■ 테이블에서 니가 원하는 것만 떼고 싶으면
subset(원본, 원본$칼럼 == '어쩌구') or
원본[원본$칼럼 == '어쩌구']

■ 칼럼 이름을 바꾸고 싶으면
원본[원본$칼럼1] <- "칼럼2"

■ ggplot + 껌바
a <- as.data.frame(a)
class(a)
a = ggplot(mapping = aes(x=x축, y=y축, fill=니가 그리고 싶은 바 유형))
b = a + geom_bar(stat = "identity")
c = b + ggtitle(title) + theme(plot.title = element_text(hjust=0.5)

■ 개쉬운 barplot
1. table
2. a = barplot(table)
3. b = barplot(a, col = *, xlab = '어쩌구', ylab = '저쩌구')


