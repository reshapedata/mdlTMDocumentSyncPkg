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
#' TmWMS_stk_dismantling_sekectBymonth()
TmWMS_stk_dismantling_sekectBymonth<- function(wms_token,fyear,fmonth) {
  sql=paste0("select
'组装单'  as billtype ,
k.parent_id as FID,
k.id as FEntryID ,
k.material_id as FMaterialID_in  ,
k.material_code as FMaterialCode_in ,
k.material_name  as  FMaterialName_in ,
k.batch_number  as Flot_in,
k.num as FInStockQty  ,
k.f_storck_id as FStockID_in ,
k.create_user_name as FInsSocker ,
k.create_time as FInStockTime
from view_material_apart_in k
where YEAR(k.create_time) = '",fyear,"'
AND MONTH(k.create_time )='",fmonth,"'
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
#' TmWMS_stk_dismantling_deleteBymonth()
TmWMS_stk_dismantling_deleteBymonth<- function(dms_token,fyear,fmonth) {
  sql=paste0("delete  from rds_dms_src_t_stk_dismantling
where YEAR(FInStockTime) = '",fyear,"' AND MONTH(FInStockTime )='",fmonth,"' ")

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
#' Tmdms_stk_dismantling_selectByfbillno()
Tmdms_stk_dismantling_selectByfbillno<- function(dms_token,fbillno) {
  sql=paste0("SELECT FBilltypeName	as	单据类型	,
FEntryID	as	关联主键id	,
FID	as	主键	,
FMaterialID_in	as	入库物料ID	,
FMaterialCode_in	as	入库物料编码	,
FMaterialName_in	as	入库物料名称	,
Flot_in	as	入库批次号	,
FinStockQty	as	入库数量	,
FStockID_in	as	入库仓库编号	,
FInStocker	as	入库人	,
FInStockTime	as	入库时间
FROM rds_dms_src_t_stk_dismantling
where FEntryID  = '",fbillno,"' ")

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
#' Tmdms_stk_dismantling_selectBydate()
Tmdms_stk_dismantling_selectBydate<- function(dms_token,fdate) {
  sql=paste0("SELECT FBilltypeName	as	单据类型	,
FEntryID	as	关联主键id	,
FID	as	主键	,
FMaterialID_in	as	入库物料ID	,
FMaterialCode_in	as	入库物料编码	,
FMaterialName_in	as	入库物料名称	,
Flot_in	as	入库批次号	,
FinStockQty	as	入库数量	,
FStockID_in	as	入库仓库编号	,
FInStocker	as	入库人	,
FInStockTime	as	入库时间
FROM rds_dms_src_t_stk_dismantling
where CAST(FInStockTime  AS date)  = '",fdate,"' ")

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
#' Tmdms_stk_dismantling_selectBydateRange()
Tmdms_stk_dismantling_selectBydateRange<- function(dms_token,FStartDate,FEndDate) {
  sql=paste0("SELECT FBilltypeName	as	单据类型	,
FEntryID	as	关联主键id	,
FID	as	主键	,
FMaterialID_in	as	入库物料ID	,
FMaterialCode_in	as	入库物料编码	,
FMaterialName_in	as	入库物料名称	,
Flot_in	as	入库批次号	,
FinStockQty	as	入库数量	,
FStockID_in	as	入库仓库编号	,
FInStocker	as	入库人	,
FInStockTime	as	入库时间
FROM rds_dms_src_t_stk_dismantling
where CAST(FInStockTime  AS date) > ='",FStartDate,"' and CAST(FInStockTime  AS date) <= '",FEndDate,"'
             ")

  res <- tsda::sql_select2(token =dms_token,sql = sql)

  return(res)

}



