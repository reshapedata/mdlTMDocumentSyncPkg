#' wms按年月查询数据
#'
#' @param wms_token
#' @param fyear
#' @param fmonth
#'
#' @return
#' @export
#'
#' @examples
#' TmWMS_stk_assembly_sekectBymonth()
TmWMS_stk_assembly_sekectBymonth<- function(wms_token,fyear,fmonth) {
  sql=paste0("select
'拆卸单'  as billtype ,
m.id  as FID ,
m.material_id  as  Fmaterial_id_out,
m.material_code  as  Fmaterial_code_out ,
m.material_name  as  Fmaterialname_out ,
m.batch_number as Flot_out ,
m.num as  FOutstockQty ,
m.f_storck_id as FStockID_out ,
m.create_user_name as  FOutStocker ,
m.create_time as  FOutStockTime
from  view_material_apart_out m
where YEAR(m.create_time) = '",fyear,"'
AND MONTH(m.create_time )='",fmonth,"'
             ")

  res <- tsda::mysql_select2(token =wms_token,sql = sql)

  return(res)

}



#' dms按年月删除数据
#'
#' @param wms_token
#' @param fyear
#' @param fmonth
#'
#' @return
#' @export
#'
#' @examples
#' TmWMS_stk_assembly_deleteBymonth()
TmWMS_stk_assembly_deleteBymonth<- function(dms_token,fyear,fmonth) {
  sql=paste0("delete  from rds_dms_src_t_stk_assembly
where YEAR(FOutStockTime) = '",fyear,"' AND MONTH(FOutStockTime)='",fmonth,"' ")

  res <- tsda::sql_delete2(token =dms_token,sql_str = sql)

  return(res)

}

#' dms按单据编号查询数据
#'
#' @param dms_token
#' @param fbillno
#'
#' @return
#' @export
#'
#' @examples
#' Tmdms_stk_assembly_selectByfbillno()
Tmdms_stk_assembly_selectByfbillno<- function(dms_token,fbillno) {
  sql=paste0("SELECT
FBilltypeName	as	单据类型	,
FID	as	主键out_id	,
FMaterialID_out	as	出库物料ID	,
FMaterialCode_out	as	出库物料编码	,
FMaterialName_out	as	出库物料名称	,
Flot_out	as	出库批次号	,
FOutStockQty	as	出库数量	,
FStockID_out	as	出库仓库编号	,
FOutStocker	as	出库人	,
FOutStockTime	as	出库时间
FROM rds_dms_src_t_stk_assembly
where FID  = '",fbillno,"' ")

  res <- tsda::sql_select2(token =dms_token,sql = sql)

  return(res)

}




#' dms按日期查询数据
#'
#' @param dms_token
#' @param fdate
#'
#' @return
#' @export
#'
#' @examples
#' Tmdms_stk_assembly_selectBydate()
Tmdms_stk_assembly_selectBydate<- function(dms_token,fdate) {
  sql=paste0("SELECT
FBilltypeName	as	单据类型	,
FID	as	主键out_id	,
FMaterialID_out	as	出库物料ID	,
FMaterialCode_out	as	出库物料编码	,
FMaterialName_out	as	出库物料名称	,
Flot_out	as	出库批次号	,
FOutStockQty	as	出库数量	,
FStockID_out	as	出库仓库编号	,
FOutStocker	as	出库人	,
FOutStockTime	as	出库时间
FROM rds_dms_src_t_stk_assembly
where CAST(FOutStockTime  AS date)  = '",fdate,"' ")

  res <- tsda::sql_select2(token =dms_token,sql = sql)

  return(res)

}


#' dms按日期范围查询数据
#'
#' @param dms_token
#' @param fdate
#'
#' @return
#' @export
#'
#' @examples
#' Tmdms_stk_assembly_selectBydateRange()
Tmdms_stk_assembly_selectBydateRange<- function(dms_token,FStartDate,FEndDate) {
  sql=paste0("SELECT
FBilltypeName	as	单据类型	,
FID	as	主键out_id	,
FMaterialID_out	as	出库物料ID	,
FMaterialCode_out	as	出库物料编码	,
FMaterialName_out	as	出库物料名称	,
Flot_out	as	出库批次号	,
FOutStockQty	as	出库数量	,
FStockID_out	as	出库仓库编号	,
FOutStocker	as	出库人	,
FOutStockTime	as	出库时间
FROM rds_dms_src_t_stk_assembly
where CAST(FOutStockTime  AS date) > ='",FStartDate,"' and CAST(FOutStockTime  AS date) <= '",FEndDate,"'
             ")

  res <- tsda::sql_select2(token =dms_token,sql = sql)

  return(res)

}



