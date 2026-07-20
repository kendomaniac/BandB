#' mkDB
#'
#' @description This function is designed to create a students csv file with the 4 score initialised as NA.
#' @param new_students, a character string indicating the path and the excel file containing the new students
#' @param studentDB, a character string indicating the path of csv file containing the previous set of students
#' @param updateDB, a logical FALSE, this is a new db to be built from scratch and save in studentDB, TRUE update the db at studentDB, this is done every new year whne new students are incoming
#'
#' @return It returns a student database populated with the new students every new year
#' @author Raffaele Calogero
#'
#' @examples
#' \dontrun{
#' mkDB(
#'   new_students = "/the/input/dir/file.csv",
#'   studentDB = "studentsdb.csv",
#'   updateDB = T
#' )
#' # first DB
#' mkDB(
#'   new_students = paste(getwd(), "1anno_Canali_ABCD_25-26.csv", sep="/"),
#'   updateDB = F
#' )
#' }
#' @export
mkDB <- function(new_students, studentDB=NULL, updateDB=FALSE) {
  new_set = utils::read.csv(new_students)
  new_set = new_set[,1:4]# butta le colonne vuote
  new_set <- new_set[rowSums(is.na(new_set)) == 0, ]#rimuonve le righe che hanno NA
  if(updateDB == TRUE){
    db = utils::read.csv(studentDB)
    new_set_tmp = data.frame(new_set, bioc = NA, bm = NA, gen = NA, biol = NA)
    db = rbind(db, new_set_tmp)
    db = as.data.frame(db)
    utils::write.csv(db, paste0(getwd(),"/studentDB_", format(Sys.Date(), "%Y-%m-%d"),".csv"), row.names = F)
  } else{
    db = data.frame(new_set, cfu = NA, bioc = NA, bm = NA, gen = NA, biol = NA, bioc.norm = NA, bm.norm = NA, gen.norm = NA, biol.norm = NA)
    utils::write.csv(db, paste0(getwd(),"/studentDB_", format(Sys.Date(), "%Y-%m-%d"),".csv"), row.names = F)
  }
}


