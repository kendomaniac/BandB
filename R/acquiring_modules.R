#' loadExam
#'
#' @description This function is designed to create a data.frame where, given a specific module, a normalised score is generated.
#' @param exam_file, a character string indicating the path and the excel file containing the exam results
#' @param type, a character string indicating the exam type. Four options: bioc 9 credits, bm 5 credits, gen 3 credits and biol 1 credit
#'
#' @return It returns a data.frame with the information of the students which have passed a specific module
#' @author Raffaele Calogero
#'
#' @examples
#' \dontrun{
#' bioc = loadExam(exam_file=paste(getwd(), "bioc.xls",sep="/"), type="bioc")
#' bm = loadExam(exam_file=paste(getwd(), "bm.xls",sep="/"), type="bm")
#' g = loadExam(exam_file=paste(getwd(), "g.xls",sep="/"), type="gen")
#' biol = loadExam(exam_file=paste(getwd(), "biol.xls",sep="/"), type="biol")
#' }
#' @export
loadExam = function(exam_file, type=c("bioc","bm","gen","biol")){
  tmp = readxl::read_excel(exam_file, sheet=1, skip = 19)
  tmp = as.data.frame(tmp)
  shrinked_df = tmp[,c(3:7,9)]
  shrinked_df$norm = NA
  shrinked_df$CFU = as.integer(shrinked_df$CFU)
  shrinked_df$Esito = as.integer(shrinked_df$Esito)
  shrinked_df$Esito[is.na(shrinked_df$Esito)] = 0
  #assigning the correct value to nomalise score give a different set of CFU
  cfu_type <- c(
    bioc = 9,
    bm   = 5,
    gen  = 2,
    biol = 1
  )
  for(i in 1:dim(shrinked_df)[1]){
    if (type %in% names(cfu_type) && shrinked_df$CFU[i] >= cfu_type[type]){
      if(shrinked_df$Esito[i] >= 18){
        shrinked_df$norm[i] <- shrinked_df$Esito[i] / shrinked_df$CFU[i] * cfu_type[type]
      } else{
        shrinked_df$norm[i] = NA
      }
    }
  }
  return(shrinked_df)
}