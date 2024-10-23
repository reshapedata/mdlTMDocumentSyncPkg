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
#' TmWMS_stk_misdelivery_crush_sekectBymonth()
TmWMS_stk_misdelivery_crush_sekectBymonth<- function(wms_token,fyear,fmonth) {
  sql=paste0("select
'其他出库单_粉碎出库'  as billtype ,
j.order_id  as FID ,
j.id  as FEntryID ,
j.package_code ,
j.remark ,
j.material_id ,
j.material_code ,
j.material_name ,
j.num ,
j.f_base_unit_name ,
j.batch_number ,
j.number_str ,
j.create_user ,
j.create_user_name ,
j.create_time
from view_waste_crush_order_detail j
where YEAR(j.create_time) = '",fyear,"'
AND MONTH(j.create_time)='",fmonth,"' ")

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
#' TmWMS_stk_misdelivery_crush_deleteBymonth()
TmWMS_stk_misdelivery_crush_deleteBymonth<- function(dms_token,fyear,fmonth) {
  sql=paste0("delete  from rds_dms_src_t_stk_misdelivery_crush
where YEAR(FCreateTime) = '",fyear,"' AND MONTH(FCreateTime)='",fmonth,"' ")

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
#' Tmdms_stk_misdelivery_crush_selectByfbillno()
Tmdms_stk_misdelivery_crush_selectByfbillno<- function(dms_token,fbillno) {
  sql=paste0("select
FBilltypeName	as	单据类型,
FID	as	废料粉碎主表id,
FEntryID	as	主键id	,
FPackadeCode	as	包装码	,
FRemark	as	类型标识	,
FMaterialID	as	物料id	,
FMaterialCode	as	物料编号	,
FMaterialName	as	物料名称	,
FCrushQty	as	入待粉碎_数量	,
Funit	as	单位	,
Fflot	as	批次号	,
FFLow	as	流水号	,
FCreatorID_in	as	创建人ID	,
Fcreator_out	as	创建人姓名	,
FCreateTime	as	创建时间
from rds_dms_src_t_stk_misdelivery_crush
where FID = '",fbillno,"' ")

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
#' Tmdms_stk_misdelivery_crush_selectBydate()
Tmdms_stk_misdelivery_crush_selectBydate<- function(dms_token,fdate) {
  sql=paste0("select
FBilltypeName	as	单据类型,
FID	as	废料粉碎主表id,
FEntryID	as	主键id	,
FPackadeCode	as	包装码	,
FRemark	as	类型标识	,
FMaterialID	as	物料id	,
FMaterialCode	as	物料编号	,
FMaterialName	as	物料名称	,
FCrushQty	as	入待粉碎_数量	,
Funit	as	单位	,
Fflot	as	批次号	,
FFLow	as	流水号	,
FCreatorID_in	as	创建人ID	,
Fcreator_out	as	创建人姓名	,
FCreateTime	as	创建时间
from rds_dms_src_t_stk_misdelivery_crush
where CAST(FCreateTime AS date) = '",fdate,"' ")

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
#' Tmdms_stk_misdelivery_crush_selectBydateRange()
Tmdms_stk_misdelivery_crush_selectBydateRange<- function(dms_token,FStartDate,FEndDate) {
  sql=paste0("select
FBilltypeName	as	单据类型,
FID	as	废料粉碎主表id,
FEntryID	as	主键id	,
FPackadeCode	as	包装码	,
FRemark	as	类型标识	,
FMaterialID	as	物料id	,
FMaterialCode	as	物料编号	,
FMaterialName	as	物料名称	,
FCrushQty	as	入待粉碎_数量	,
Funit	as	单位	,
Fflot	as	批次号	,
FFLow	as	流水号	,
FCreatorID_in	as	创建人ID	,
Fcreator_out	as	创建人姓名	,
FCreateTime	as	创建时间
from rds_dms_src_t_stk_misdelivery_crush
where CAST(FCreateTime AS date) > ='",FStartDate,"' and CAST(FCreateTime AS date) <= '",FEndDate,"' ")

  res <- tsda::sql_select2(token =dms_token,sql = sql)

  return(res)

}



