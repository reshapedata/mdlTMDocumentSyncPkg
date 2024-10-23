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
#' TmWMS_stk_miscellaneous_crush_sekectBymonth()
TmWMS_stk_miscellaneous_crush_sekectBymonth<- function(wms_token,fyear,fmonth) {
  sql=paste0("select
'其他入库单_粉碎入库'  as billtype ,
h.id as FID,
h.material_id ,
h.material_code ,
h.material_name ,
h.f_base_unit_name ,
h.batch_number ,
h.package_code ,
h.pre_crush_num ,
h.crush_num ,
h.ratio ,
h.diff_num ,
h.remark ,
h.staus as f_status ,
h.number_str ,
h.create_user ,
h.create_user_name ,
h.create_time ,
h.confirm_user ,
h.confirm_user_name ,
h.confirm_time

from view_waste_crush_order  h
where YEAR(h.create_time) = '",fyear,"'
AND MONTH(h.create_time)='",fmonth,"' ")

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
#' TmWMS_stk_miscellaneous_crush_deleteBymonth()
TmWMS_stk_miscellaneous_crush_deleteBymonth<- function(dms_token,fyear,fmonth) {
  sql=paste0("delete  from rds_dms_src_t_stk_miscellaneous_crush
where YEAR(FcreateTime_in) = '",fyear,"' AND MONTH(FcreateTime_in)='",fmonth,"' ")

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
#' Tmdms_stk_miscellaneous_crush_selectByfbillno()
Tmdms_stk_miscellaneous_crush_selectByfbillno<- function(dms_token,fbillno) {
  sql=paste0("SELECT
FBilltypeName	as	单据类型	,
FID	as	主键id	,
FMaterialID_in	as	物料id	,
FMaterialCode_in	as	物料编号	,
FMaterialName_in	as	物料名称	,
Funit	as	单位	,
Flot_in	as	批次号	,
FPackadeCode	as	包装码	,
FPreCrushQty	as	粉碎前数量	,
FCrushQty	as	粉碎后数量	,
Fratio	as	粉碎比例	,
FDiffQty	as	差异值	,
FRemark	as	类型标识	,
Fstatus_in	as	状态	,
FFLowNo_in	as	流水号	,
FCreatorID_in	as	创建人ID	,
FCreateName_in	as	创建人姓名	,
FcreateTime_in	as	创建时间	,
FconfirmID_in	as	确认人ID	,
FConfirmName_in	as	确认人姓名	,
FconfirmTime_in	as	确认时间
FROM rds_dms_src_t_stk_miscellaneous_crush
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
#' Tmdms_stk_miscellaneous_crush_selectBydate()
Tmdms_stk_miscellaneous_crush_selectBydate<- function(dms_token,fdate) {
  sql=paste0("SELECT
FBilltypeName	as	单据类型	,
FID	as	主键id	,
FMaterialID_in	as	物料id	,
FMaterialCode_in	as	物料编号	,
FMaterialName_in	as	物料名称	,
Funit	as	单位	,
Flot_in	as	批次号	,
FPackadeCode	as	包装码	,
FPreCrushQty	as	粉碎前数量	,
FCrushQty	as	粉碎后数量	,
Fratio	as	粉碎比例	,
FDiffQty	as	差异值	,
FRemark	as	类型标识	,
Fstatus_in	as	状态	,
FFLowNo_in	as	流水号	,
FCreatorID_in	as	创建人ID	,
FCreateName_in	as	创建人姓名	,
FcreateTime_in	as	创建时间	,
FconfirmID_in	as	确认人ID	,
FConfirmName_in	as	确认人姓名	,
FconfirmTime_in	as	确认时间
FROM rds_dms_src_t_stk_miscellaneous_crush
where CAST(FcreateTime_in AS date) = '",fdate,"' ")

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
#' Tmdms_stk_miscellaneous_crush_selectBydateRange()
Tmdms_stk_miscellaneous_crush_selectBydateRange<- function(dms_token,FStartDate,FEndDate) {
  sql=paste0("SELECT
FBilltypeName	as	单据类型	,
FID	as	主键id	,
FMaterialID_in	as	物料id	,
FMaterialCode_in	as	物料编号	,
FMaterialName_in	as	物料名称	,
Funit	as	单位	,
Flot_in	as	批次号	,
FPackadeCode	as	包装码	,
FPreCrushQty	as	粉碎前数量	,
FCrushQty	as	粉碎后数量	,
Fratio	as	粉碎比例	,
FDiffQty	as	差异值	,
FRemark	as	类型标识	,
Fstatus_in	as	状态	,
FFLowNo_in	as	流水号	,
FCreatorID_in	as	创建人ID	,
FCreateName_in	as	创建人姓名	,
FcreateTime_in	as	创建时间	,
FconfirmID_in	as	确认人ID	,
FConfirmName_in	as	确认人姓名	,
FconfirmTime_in	as	确认时间
FROM rds_dms_src_t_stk_miscellaneous_crush
where CAST(FcreateTime_in AS date) > ='",FStartDate,"' and CAST(FcreateTime_in AS date) <= '",FEndDate,"'
             ")

  res <- tsda::sql_select2(token =dms_token,sql = sql)

  return(res)

}



