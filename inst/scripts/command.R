

library(BandB)
#creating the new DB solo la prima volta
mkDB(
  new_students = paste(getwd(), "1anno_Canali_ABCD_25-26.csv", sep="/"),
  updateDB = F
)

############################ start updating db results #############################
#load available db
setwd("/Users/raffaelecalogero/Library/CloudStorage/OneDrive-Personal/Documents/didattica/aggregazione_medicina_biochimica-biologia/BandB")
db = read.csv("studentDB_2026-07-20.csv")
#lastest updated db
db = read.csv("studentDB_2026-07-20_18-39-48.csv")


#A
setwd("/Users/raffaelecalogero/Library/CloudStorage/OneDrive-Personal/Documents/didattica/aggregazione_medicina_biochimica-biologia/BandB/canaleA/luglio1")
bioc = loadExam(exam_file=paste(getwd(), "bioc.xls",sep="/"), type="bioc")
bm = loadExam(exam_file=paste(getwd(), "bm.xls",sep="/"), type="bm")
g = loadExam(exam_file=paste(getwd(), "g.xls",sep="/"), type="gen")
biol = loadExam(exam_file=paste(getwd(), "biol.xls",sep="/"), type="biol")

db = populatingDB(norm_score = bioc, studentDB = db, type="bioc")
db = populatingDB(norm_score = bm, studentDB = db, type="bm")
db = populatingDB(norm_score = g, studentDB = db, type="gen")
db = populatingDB(norm_score = biol, studentDB = db, type="biol")
rm(list=c("bioc", "bm", "g", "biol"))

#B
setwd("/Users/raffaelecalogero/Library/CloudStorage/OneDrive-Personal/Documents/didattica/aggregazione_medicina_biochimica-biologia/BandB/canaleB/luglio1")
bioc = loadExam(exam_file=paste(getwd(), "bioc.xls",sep="/"), type="bioc")
bm = loadExam(exam_file=paste(getwd(), "bm.xls",sep="/"), type="bm")
g = loadExam(exam_file=paste(getwd(), "g.xls",sep="/"), type="gen")
biol = loadExam(exam_file=paste(getwd(), "biol.xls",sep="/"), type="biol")

db = populatingDB(norm_score = bioc, studentDB = db, type="bioc")
db = populatingDB(norm_score = bm, studentDB = db, type="bm")
db = populatingDB(norm_score = g, studentDB = db, type="gen")
db = populatingDB(norm_score = biol, studentDB = db, type="biol")
rm(list=c("bioc", "bm", "g", "biol"))

#C
setwd("/Users/raffaelecalogero/Library/CloudStorage/OneDrive-Personal/Documents/didattica/aggregazione_medicina_biochimica-biologia/BandB/canaleC/luglio1")
bioc = loadExam(exam_file=paste(getwd(), "bioc.xls",sep="/"), type="bioc")
bm = loadExam(exam_file=paste(getwd(), "bm.xls",sep="/"), type="bm")
g = loadExam(exam_file=paste(getwd(), "g.xls",sep="/"), type="gen")
biol = loadExam(exam_file=paste(getwd(), "biol.xls",sep="/"), type="biol")

db = populatingDB(norm_score = bioc, studentDB = db, type="bioc")
db = populatingDB(norm_score = bm, studentDB = db, type="bm")
db = populatingDB(norm_score = g, studentDB = db, type="gen")
db = populatingDB(norm_score = biol, studentDB = db, type="biol")
rm(list=c("bioc", "bm", "g", "biol"))

#D
setwd("/Users/raffaelecalogero/Library/CloudStorage/OneDrive-Personal/Documents/didattica/aggregazione_medicina_biochimica-biologia/BandB/canaleD/luglio1")
bioc = loadExam(exam_file=paste(getwd(), "bioc.xls",sep="/"), type="bioc")
bm = loadExam(exam_file=paste(getwd(), "bm.xls",sep="/"), type="bm")
g = loadExam(exam_file=paste(getwd(), "g.xls",sep="/"), type="gen")
biol = loadExam(exam_file=paste(getwd(), "biol.xls",sep="/"), type="biol")

db = populatingDB(norm_score = bioc, studentDB = db, type="bioc")
db = populatingDB(norm_score = bm, studentDB = db, type="bm")
db = populatingDB(norm_score = g, studentDB = db, type="gen")
db = populatingDB(norm_score = biol, studentDB = db, type="biol")
rm(list=c("bioc", "bm", "g", "biol"))

setwd("/Users/raffaelecalogero/Library/CloudStorage/OneDrive-Personal/Documents/didattica/aggregazione_medicina_biochimica-biologia/BandB")
utils::write.csv(db, paste0(getwd(),"/studentDB_", format(Sys.time(), "%Y-%m-%d_%H-%M-%S"),".csv"), row.names = F) #writing the updated studentDB

######################################## end updating db results ############################################
#generating the verbalising exam using the latest updated db and being locate where verbalizzante.xls is
pathDB="/Users/raffaelecalogero/Library/CloudStorage/OneDrive-Personal/Documents/didattica/aggregazione_medicina_biochimica-biologia/BandB/"
db="studentDB_2026-07-20_18-39-48.csv"
scoring(registered_students = "verbalizzante.xls", studentDB = paste0(pathDB, db))
