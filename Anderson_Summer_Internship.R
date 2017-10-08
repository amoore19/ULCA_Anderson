
#A brief breakdown of the UCLA Anderson 2nd Year Internship File.


#Sets the location of the MBA networking file. If the directory does not exist, then
#we create the directory.
if (dir.exists("C:/Projects/MBA_Networking")==FALSE){
  dir.create("C:/Projects/MBA_Networking")
}

setwd("C:/Projects/MBA_Networking/")

#Here we create three new variables to signify a Tech, Corporate (Finance),
#or Analytics job.
Intern_File<-read.csv(file="2018_UCLA_Interns.csv",header=TRUE)
Intern_File$Tech <- ifelse(grepl("Tech", Intern_File$Detailed.Industry), "Yes", "No")
Intern_File$Corporate <- ifelse(grepl("Corporate", Intern_File$Detailed.Function), "Yes", "No")
Intern_File$Analytics<-ifelse(grepl("Analytics", Intern_File$Detailed.Function), "Yes", "No")


#We break the data set into three parts Tech, Corporate, and Analytics
Tech<-Intern_File[Intern_File$Tech=="Yes",]
Corporate<-Intern_File[Intern_File$Corporate=="Yes",]
Analytics<-Intern_File[Intern_File$Analytics=="Yes",]

#We aggregate the data set back to the final data set of second years.
final<-rbind(Tech, Corporate, Analytics)
write.csv(final,file="final.csv")

#Create a list of industries in our final data set.
Industry_List<-as.data.frame(unique(final$Detailed.Industry))

if (dir.exists("C:/Projects/MBA_Networking/ByIndustry")==FALSE){
  dir.create("C:/Projects/MBA_Networking/ByIndustry")
}

setwd("C:/Projects/MBA_Networking/ByIndustry")

for (i in (1:nrow(Industry_List))){
temp<-final[final$Detailed.Industry==Industry_List[i,],]
output<-paste(gsub("/","_",Industry_List[i,]),".csv",sep="")
write.csv(temp,file=output)

}
