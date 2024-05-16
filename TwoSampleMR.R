setwd(dirname(parent.frame(2)$filename))
input_file <- './data/ieu-a-2.vcf.gz'
threshold <- 5e-08
output_fmt <- "png"


# 筛选强关联的 SNP --------------------------------------------------------------


# ---读取数据并转换为 TwoSampleMR 格式
vcf_data <- readVcf(input_file)
two_sample_MR_data <- gwasvcf_to_TwoSampleMR(vcf = vcf_data, type = "exposure")

# ---滤去关联性弱的 SNP 并输出到文件
out_table <- subset(two_sample_MR_data, pval.exposure < threshold)
write.csv(out_table, file = "exposure.pvalue.csv", row.names = FALSE)

# ---曼哈顿图数据准备
# SNP：SNP ID
# CHR：染色体名称
# BP：基因位点（Base Pair）
# pvalue：P值
two_sample_MR_data <- two_sample_MR_data[, c("SNP", "chr.exposure", "pos.exposure", "pval.exposure")]
colnames(two_sample_MR_data) <- c("SNP", "CHR", "BP", "pvalue")

# ---绘制输出（“m”线性曼哈顿图，“c”环形曼哈顿图）
CMplot(two_sample_MR_data, plot.type = "m",
       LOG10 = TRUE, threshold = threshold, threshold.lwd = 3, threshold.lty = 1, signal.cex = 0.2,
       chr.den.col = NULL, cex = 0.2, bin.size = 1e5, ylim = c(0, 50), width = 15, height = 9,
       file.output = TRUE, file = output_fmt, verbose = TRUE)
CMplot(two_sample_MR_data, plot.type = "c",
       LOG10 = TRUE, threshold = threshold, threshold.lwd = 3, threshold.lty = 1, signal.cex = 0.2,
       chr.den.col = NULL, cex = 0.2, bin.size = 1e5, ylim = c(0, 100), width = 7, height = 7,
       file.output = TRUE, file = output_fmt, verbose = TRUE)