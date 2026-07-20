#' scoring
#'
#' @description This function is designed to create a students csv file with the 4 score initialised as NA.
#' @param registered_students, a character string indicating the path and the excel file containing the students registered for the final scoring
#' @param studentDB, a character string indicating the path of the ladtes csv file containing students and results
#'
#' @return It returns a comma separated file verbalising_tmp.csv with the names of students to be verbalised and a file called verbalising_to_be_manually_revised.csv in case there are students with less than 17 credits to be handled manually.
#' @author Raffaele Calogero
#'
#' @examples
#' \dontrun{
#' scoring(
#'   registered_students = "/the/input/dir/verbalizzante.xls",
#'   studentDB = "/somewhere/studentDB_2026-07-15_18-49-07.csv"
#' )
#' }
#' @export
scoring <- function(registered_students, studentDB) {
  registered = readxl::read_excel(registered_students, sheet=1, skip = 19)
  registered = as.data.frame(registered)
  registered = registered[, c(3:7,9)]
  registered$Matricola = as.character(registered$Matricola)
  registered$CFU = as.integer(registered$CFU)
  registered_all = registered$Matricola[which(registered$CFU == 17)]
  registered_others = registered$Matricola[which(registered$CFU < 17)]
  students = utils::read.csv(studentDB)
  students_sub_all = students[which(as.character(students$MATRICOLA) %in% registered_all),]
  students_sub_all <- students_sub_all[stats::complete.cases(students_sub_all[,7:13]), ]
  if(length(registered_others) > 0){
    students_sub_others = students[which(as.character(students$MATRICOLA) %in% registered_others),]
    utils::write.csv(students_sub_others, paste0(getwd(),"/verbalising_to_be_manually_revised.csv"), row.names = F)
  }
  tmp = apply(students_sub_all[,6:9], 1, function(x) all(!is.na(x) & x != 0))
  students_sub_all = students_sub_all[tmp,]
  students_sub_all$final = apply(students_sub_all[,10:13], 1, sum)
  utils::write.csv(students_sub_all, paste0(getwd(),"/verbalising.csv"), row.names = F)
}


